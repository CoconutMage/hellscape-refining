local RESOURCE_NAME = "oil-reservoir"   -- your resource entity name
local RESOURCE_NAME_TWO = "crude-oil"
local NEW_RESOURCE = "crude-oil"
local RESPAWN_AMOUNT = 2000         -- amount for the new well (finite resource)
local SEARCH_RADIUS = 12              -- how far we look for an empty spot (if same tile blocked)
local CHUNK_SIZE = 32



local TICKS_PER_SECOND = 60
local BASE_Q_PER_WELL = 8.0     -- fluid/sec at pressure=1 and full reservoir
local DECLINE_GAMMA   = 0.85    -- >1 steeper drop, <1 gentler drop
local MIN_FRAC        = 0.0     -- set >0 later if you want a floor


local function compute_q_total(reservoir, active_wells_count)
  if reservoir.initial_remaining <= 0 then return 0 end
  if reservoir.remaining <= 0 then return 0 end
  if active_wells_count <= 0 then return 0 end

  local frac = reservoir.remaining / reservoir.initial_remaining
  if frac < MIN_FRAC then frac = MIN_FRAC end

  local decline = frac ^ DECLINE_GAMMA
  local pressure = reservoir.pressure or 1.0

  return BASE_Q_PER_WELL * active_wells_count * pressure * decline
end


local function init_storage()
  storage.reservoirs = storage.reservoirs or {}                 -- [reservoir_id] -> data
  storage.resource_to_reservoir = storage.resource_to_reservoir or {} -- [resource_unit_number] -> reservoir_id
  storage.player_gui_state = storage.player_gui_state or {}
end

script.on_init(init_storage)
script.on_configuration_changed(init_storage)

local function chunk_coord(v) return math.floor(v / CHUNK_SIZE) end
local function chunk_key(cx, cy) return cx .. "," .. cy end
local function tile_key(tx, ty) return tx .. "," .. ty end
local function to_tile_xy(pos) return math.floor(pos.x), math.floor(pos.y) end

local function load_resource_chunk(surface, cx, cy, cache)
  local ck = chunk_key(cx, cy)
  if cache.loaded_chunks[ck] then return end
  cache.loaded_chunks[ck] = true

  local lt = { cx * CHUNK_SIZE, cy * CHUNK_SIZE }
  local rb = { (cx + 1) * CHUNK_SIZE, (cy + 1) * CHUNK_SIZE }

  local ents = surface.find_entities_filtered{
    area = { lt, rb },
    type = "resource",
    name = RESOURCE_NAME
  }

  for _, e in pairs(ents) do
    if e.valid then
      local tx, ty = to_tile_xy(e.position)
      cache.by_tile[tile_key(tx, ty)] = e
    end
  end
end

local function flood_connected_patch(surface, seed_position, use_diagonals)
  local cache = { loaded_chunks = {}, by_tile = {} }

  local sx, sy = to_tile_xy(seed_position)
  load_resource_chunk(surface, chunk_coord(sx), chunk_coord(sy), cache)

  local seed_ent = cache.by_tile[tile_key(sx, sy)]
  if not (seed_ent and seed_ent.valid) then
    return {}, nil
  end

  local dirs4 = { {1,0},{-1,0},{0,1},{0,-1} }
  local dirs8 = { {1,0},{-1,0},{0,1},{0,-1},{1,1},{1,-1},{-1,1},{-1,-1} }
  local dirs = use_diagonals and dirs8 or dirs4

  local visited = {}
  local queue = { {sx, sy} }
  local qh = 1
  visited[tile_key(sx, sy)] = true

  local patch = {}
  local minx, miny, maxx, maxy = sx, sy, sx, sy

  while qh <= #queue do
    local tx, ty = queue[qh][1], queue[qh][2]
    qh = qh + 1

    load_resource_chunk(surface, chunk_coord(tx), chunk_coord(ty), cache)

    local ent = cache.by_tile[tile_key(tx, ty)]
    if ent and ent.valid then
      patch[#patch + 1] = ent

      if tx < minx then minx = tx end
      if ty < miny then miny = ty end
      if tx > maxx then maxx = tx end
      if ty > maxy then maxy = ty end

      for _, d in ipairs(dirs) do
        local nx, ny = tx + d[1], ty + d[2]
        local nk = tile_key(nx, ny)
        if not visited[nk] then
          visited[nk] = true
          load_resource_chunk(surface, chunk_coord(nx), chunk_coord(ny), cache)
          if cache.by_tile[nk] and cache.by_tile[nk].valid then
            queue[#queue + 1] = { nx, ny }
          end
        end
      end
    end
  end

  return patch, { x=sx, y=sy }
end

local function create_reservoir_from_patch(surface, patch, seed_tile)
  local anchor_tile = seed_tile
  local reservoir_id = surface.index .. ":" .. anchor_tile.x .. "," .. anchor_tile.y
  log("Creating Res: "..reservoir_id)

  -- If collision somehow happens, disambiguate (rare but safe)
  if storage.reservoirs[reservoir_id] then
    local n = 2
    while storage.reservoirs[reservoir_id .. "#" .. n] do n = n + 1 end
    reservoir_id = reservoir_id .. "#" .. n
  end

  storage.reservoirs[reservoir_id] = {
    surface_index = surface.index,
    anchor_tile = anchor_tile,
    resource_count = #patch,
    wells = {},          -- [well_unit_number] = true
    pressure = 1.0,      -- for later options
    remaining = 865,     -- you can compute later from resource.amount if desired
    initial_remaining = 865,
    last_rate = 0,
  }
  log("Res Created: "..reservoir_id)

  -- THE IMPORTANT CACHE: every resource entity in the patch points to this reservoir_id
  for _, e in ipairs(patch) do
    if e.valid then

      storage.resource_to_reservoir[surface.index .. ":" .. e.position.x .. "," .. e.position.y] = reservoir_id
    end
  end

  return reservoir_id
end

local function find_nearest_resource(surface, position, radius)
  local ents = surface.find_entities_filtered{
    type = "resource",
    name = RESOURCE_NAME,
    position = position,
    radius = radius or 3
  }

  local best, best_d2
  for _, e in pairs(ents) do
    if e.valid then
      local dx = e.position.x - position.x
      local dy = e.position.y - position.y
      local d2 = dx*dx + dy*dy
      if not best or d2 < best_d2 then
        best, best_d2 = e, d2
      end
    end
  end
  return best
end

local function get_or_create_reservoir_for_well(surface, well_position)

  local seed_resource = find_nearest_resource(surface, well_position, 4)
  if not (seed_resource and seed_resource.valid) then
    return nil -- not on/near a field
  end

  local existing_id = storage.resource_to_reservoir[surface.index .. ":" .. well_position.x .. "," .. well_position.y]
  if existing_id and storage.reservoirs[existing_id] then
    log("Found Existing Res: "..existing_id)
    return existing_id
  end

  -- Create reservoir (flood fill ONCE)
  local patch, seed_tile = flood_connected_patch(surface, seed_resource.position, true)
  if #patch == 0 then return nil end

  return create_reservoir_from_patch(surface, patch, seed_tile)
end

local function attach_well_to_reservoir(well_entity, reservoir_id)
  local r = storage.reservoirs[reservoir_id]
  r.wells[#r.wells + 1] = well_entity
  log("Attaching Well")
end

local function removeWell(e)
  local ent = e.entity
  if not (ent and ent.valid) then return end
  if ent.name ~= "deep-oil-drill" then return end

  local surface = ent.surface
  local pos = ent.position

  local reservoir_id = get_or_create_reservoir_for_well(surface, pos)
  if not reservoir_id then return end

  local r = storage.reservoirs[reservoir_id]
  for i = #r.wells, 1, -1 do
  if r.wells[i] == ent then
    table.remove(r.wells, i)
    break
  end
end
  log("Removing Well")
end

local function try_spawn_well(surface, position)

  log("Well ran dry")

  local tile_pos, resource_two_ent, reservoir_key, found =
      find_first_resource_two_touching_patch(surface, position, true)

  local marker

  if found then
    log("Found Reservoir")
      -- Existing reservoir
      marker = resource_two_ent
      reservoir_key = marker.position

      if not storage.reservoirs[reservoir_key] then
          -- Reservoir marker exists but data missing (rare but possible after reload)
          storage.reservoirs[reservoir_key] = {
              marker = marker,
              position = marker.position,
              remaining = marker.amount or RESPAWN_AMOUNT,
              wells = {}
          }
      end

  else
    log("Creating Reservoir")
      -- No reservoir found → create one
      reservoir_key, marker = create_reservoir(surface, position)

      if not reservoir_key then
          return false
      end
  end

  -- Spawn the new well entity
  local well = surface.create_entity{
      name = NEW_RESOURCE,
      position = position,
      amount = RESPAWN_AMOUNT,
      snap_to_tile_center = true
  }

  if not well then
      return false
  end

  -- Attach well to reservoir
  storage.wells[well.position] = {
      entity = well,
      reservoir_key = reservoir_key
  }

  table.insert(storage.reservoirs[reservoir_key].wells, well.position)

  log("Well attached to reservoir " .. reservoir_key)

  return true
end

script.on_event(defines.events.on_resource_depleted, function(event)
  local entity = event.entity
  log("Running dry Well: " .. entity.name)
  if not (entity and entity.valid) then return end
  if entity.name ~= RESOURCE_NAME then return end

  local surface = entity.surface
  local pos = entity.position

  local reservoir_id = get_or_create_reservoir_for_well(surface, pos)

  log("Res id: " ..reservoir_id)
  if not reservoir_id then return end

  --attach_well_to_reservoir(entity, reservoir_id)
  local well = surface.create_entity{
      name = NEW_RESOURCE,
      position = pos,
      amount = storage.reservoirs[reservoir_id].remaining,
      snap_to_tile_center = true
  }
  -- spawn replacement immediately
  --try_spawn_well(surface, pos)
end)

script.on_event(defines.events.on_built_entity, function(e)
  local ent = e.entity
  if not (ent and ent.valid) then return end
  if ent.name ~= "deep-oil-drill" then return end

  local surface = ent.surface
  local pos = ent.position

  local reservoir_id = get_or_create_reservoir_for_well(surface, pos)
  if not reservoir_id then return end

  attach_well_to_reservoir(ent, reservoir_id)
end)

script.on_event(defines.events.on_player_mined_entity, removeWell)
script.on_event(defines.events.on_robot_mined_entity, removeWell)
script.on_event(defines.events.on_entity_died, removeWell)
script.on_event(defines.events.script_raised_destroy, removeWell)


local function drillOil(e)
  for reservoir_id in pairs(storage.reservoirs) do
    local r = storage.reservoirs[reservoir_id]
    if not r then
      goto continue_reservoir
    end

    -- Build a compact list of valid wells this tick

    local n = #r.wells
    if n == 0 then
      goto continue_reservoir
    end

    local q_total = compute_q_total(r, n)
    log("Oil: " ..q_total .. " :: " .. n)
    if q_total <= 0 then goto continue_reservoir end

    -- Don’t produce more than remaining
    if q_total > r.remaining then q_total = r.remaining end

    local per_well = q_total / n
    local produced = 0
    local fluid_name = r.produced_fluid or "crude-oil"

    for i = 1, n do
      local well = r.wells[i]

      if not (well and well.valid) then
        log("Well not valid")
        return
      end

      -- insert_fluid chooses a fluidbox that accepts the fluid (filters/volume apply)
      local inserted = well.insert_fluid{ name = fluid_name, amount = per_well, temperature = 25 } or 0
      produced = produced + inserted
    end

    -- Debit reservoir only by what actually got inserted
    if produced > 0 then
      r.last_rate = produced
      r.remaining = r.remaining - produced
      if r.remaining < 0 then r.remaining = 0 end
    end

    ::continue_reservoir::
  end
end
script.on_nth_tick(TICKS_PER_SECOND, drillOil)








local DRILL_NAME    = "deep-oil-drill"

local GUI_NAME = "hellscape_refining_reservoir_tooltip"
local UPDATE_EVERY_TICKS = 30  -- ~4 updates/sec; go 30 if you want even lighter

local function get_reservoir_for_entity(ent)
  if not (ent and ent.valid) then return nil end
  local surface = ent.surface

  if ent.name == DRILL_NAME then
    return get_or_create_reservoir_for_well(surface, ent.position)
  elseif ent.name == RESOURCE_NAME then
    return get_or_create_reservoir_for_well(surface, ent.position)
  end

  return nil
end

local function destroy_gui(player)
  if not player then return end
  local root = player.gui.screen
  local gui = root and root[GUI_NAME]
  if gui and gui.valid then
    gui.destroy()
  end
  storage.player_gui_state[player.index] = nil
end

local function ensure_gui(player)
  local root = player.gui.screen
  local gui = root[GUI_NAME]
  if gui and gui.valid then return gui end

  gui = root.add{
    type = "frame",
    name = GUI_NAME,
    direction = "vertical",
    caption = "Reservoir"
  }
  gui.auto_center = true

  local body = gui.add{ type="flow", direction="vertical", name="body" }
  body.style.top_padding = 6
  body.style.bottom_padding = 6
  body.style.left_padding = 10
  body.style.right_padding = 10

  body.add{ type="label", name="line_id", caption="ID: -" }
  body.add{ type="label", name="line_amount", caption="Remaining: -" }
  body.add{ type="label", name="line_pressure", caption="Pressure: -" }
  body.add{ type="label", name="line_rate", caption="Current rate: -" }

  -- Optional close button row
  local buttons = gui.add{ type="flow", direction="horizontal", name="buttons" }
  buttons.add{ type="button", name=GUI_NAME.."_close", caption="Close" }

  return gui
end

local function format_amount(n)
  if not n then return "-" end
  -- simple compact formatting
  if n >= 1e9 then return string.format("%.2fb", n/1e9) end
  if n >= 1e6 then return string.format("%.2fm", n/1e6) end
  if n >= 1e3 then return string.format("%.1fk", n/1e3) end
  return tostring(math.floor(n))
end

local function format_pressure(p)
  if p == nil then return "-" end
  -- if you store 0..1:
  if p <= 1.0 then
    return string.format("%.0f%%", p * 100)
  end
  -- else assume “bar” or similar numeric
  return string.format("%.2f", p)
end

local function update_gui(player, reservoir_id)
  local gui = ensure_gui(player)
  local body = gui.body
  if not (body and body.valid) then return end

  local r = storage.reservoirs and storage.reservoirs[reservoir_id]
  if not r then
    body.line_id.caption = "ID: (none)"
    body.line_amount.caption = "Remaining: -"
    body.line_pressure.caption = "Pressure: -"
    body.line_rate.caption = "Current rate: -"
    return
  end

  body.line_id.caption = "ID: " .. tostring(reservoir_id)
  body.line_amount.caption = "Remaining: " .. format_amount(r.remaining) .. " units"
  body.line_pressure.caption = "Pressure: " .. format_pressure(r.pressure)

  -- Optional: show current extraction rate if you store it (e.g. r.last_rate)
  if r.last_rate then
    body.line_rate.caption = "Current rate: " .. format_amount(r.last_rate) .. "/s"
  else
    body.line_rate.caption = "Current rate: -"
  end
end


script.on_event(defines.events.on_gui_opened, function(e)
  local player = game.get_player(e.player_index)
  if not player then return end

  local ent = e.entity
  if not (ent and ent.valid) then return end

  if ent.name ~= DRILL_NAME then return end

  -- Close vanilla GUI (pumpjack/mining-drill window)
  -- This also prevents the vanilla window from sticking around behind ours.
  player.opened = nil

  -- Show our GUI
  local rid = get_reservoir_for_entity(ent)
  ensure_gui(player)
  if rid then
    update_gui(player, rid)
    -- track what they opened so we can keep updating/close cleanly
    storage.player_gui_state[player.index] = {
      reservoir_id = rid,
      entity_unit_number = ent.unit_number
    }
  else
    update_gui(player, "__none__")
    storage.player_gui_state[player.index] = {
      reservoir_id = "__none__",
      entity_unit_number = ent.unit_number
    }
  end
end)

-- Close our GUI when the player closes whatever they opened / presses E / etc.
script.on_event(defines.events.on_gui_closed, function(e)
  local player = game.get_player(e.player_index)
  if not player then return end

  destroy_gui(player)
end)

local function updateGUI(e)
  if not storage.player_gui_state then return end

  for player_index, state in pairs(storage.player_gui_state) do
    local player = game.get_player(player_index)
    if not player then
      storage.player_gui_state[player_index] = nil
    else
      -- Only update if they still have a relevant selection
      local ent = player.selected
      if not (ent and ent.valid) or (ent.name ~= DRILL_NAME and ent.name ~= RESOURCE_NAME) then
        destroy_gui(player)
      else
        -- Refresh reservoir id in case mapping changed
        local rid = get_reservoir_for_entity(ent)
        if not rid then
          update_gui(player, "__none__")
        else
          state.reservoir_id = rid
          update_gui(player, rid)
        end
      end
    end
  end
end
-- Periodic update while a relevant entity is selected
script.on_nth_tick(UPDATE_EVERY_TICKS, updateGUI)