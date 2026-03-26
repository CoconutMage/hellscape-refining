local resource_autoplace = require("resource-autoplace")
-- Optional but commonly used by mods: ensures the patch set is initialized for this resource
resource_autoplace.initialize_patch_set("oil-reservoir", true)

resource_autoplace.initialize_patch_set("hematite-ore", true)
resource_autoplace.initialize_patch_set("magnetite-ore", false)
--resource_autoplace.initialize_patch_set("taconite-ore", false)

resource_autoplace.initialize_patch_set("anthracite-coal-ore", false)
resource_autoplace.initialize_patch_set("bituminous-coal-ore", false)
resource_autoplace.initialize_patch_set("lignite-coal-ore", true)
resource_autoplace.initialize_patch_set("peat-ore", true)

resource_autoplace.initialize_patch_set("copper-oxide-ore", true)
resource_autoplace.initialize_patch_set("copper-sulfide-ore", false)

local function enable_resource_on_planet(planet_name, resource_name)
  data.raw.planet.nauvis.map_gen_settings.autoplace_controls[resource_name] = {}
  data.raw.planet.nauvis.map_gen_settings.autoplace_settings.entity.settings[resource_name] = {}
  --local planet = data.raw.planet and data.raw.planet[planet_name]
  --if not (planet and planet.map_gen_settings) then return end

  --planet.map_gen_settings.autoplace_controls =
  --  planet.map_gen_settings.autoplace_controls or {}

  --planet.map_gen_settings.autoplace_settings =
  --  planet.map_gen_settings.autoplace_settings or {}

  --planet.map_gen_settings.autoplace_settings.entity =
  --  planet.map_gen_settings.autoplace_settings.entity or {}

  --planet.map_gen_settings.autoplace_settings.entity.settings =
  --  planet.map_gen_settings.autoplace_settings.entity.settings or {}

  -- Ensure the slider/control exists on this planet
  --planet.map_gen_settings.autoplace_controls[resource_name] =
  --  planet.map_gen_settings.autoplace_controls[resource_name] or {}

  -- Ensure the entity is allowed to generate on this planet
  --planet.map_gen_settings.autoplace_settings.entity.settings[resource_name] =
  --  planet.map_gen_settings.autoplace_settings.entity.settings[resource_name] or {}
end

enable_resource_on_planet("nauvis", "oil-reservoir")

enable_resource_on_planet("nauvis", "hematite-ore")
enable_resource_on_planet("nauvis", "magnetite-ore")
--enable_resource_on_planet("nauvis", "taconite-ore")

enable_resource_on_planet("nauvis", "anthracite-coal-ore")
enable_resource_on_planet("nauvis", "bituminous-coal-ore")
enable_resource_on_planet("nauvis", "lignite-coal-ore")
enable_resource_on_planet("nauvis", "peat-ore")

enable_resource_on_planet("nauvis", "copper-oxide-ore")
enable_resource_on_planet("nauvis", "copper-sulfide-ore")


-- data-final-fixes.lua

local items = {"crude-oil", "iron-ore", "copper-ore", "coal", "uranium-ore"}
for index, item_name in pairs(items) do
  -- 1) Stop crude-oil from generating (global resource autoplace fallback)
  local crude = data.raw.resource[item_name]
  if crude then
    crude.autoplace = nil
  end

  -- 2) Remove from planet map-gen settings (Space Age / SE planets that use Planet prototypes)
  if data.raw.planet then
    for _, planet in pairs(data.raw.planet) do
      local mgs = planet.map_gen_settings
      if mgs then
        if mgs.autoplace_controls then
          mgs.autoplace_controls[item_name] = nil
        end
        if mgs.autoplace_settings
          and mgs.autoplace_settings.entity
          and mgs.autoplace_settings.entity.settings then
          mgs.autoplace_settings.entity.settings[item_name] = nil
        end
      end
    end
  end

  -- 3) REMOVE THE SLIDER: delete the autoplace-control prototype
  -- This is what actually removes it from the map generation GUI.
  if data.raw["autoplace-control"] then
    data.raw["autoplace-control"][item_name] = nil
  end

  -- 4) Optional: remove from map-gen presets so presets don't reference it
  -- (Prevents edge cases where preset definitions keep it visible/active.)
  if data.raw["map-gen-presets"] then
    for _, preset_group in pairs(data.raw["map-gen-presets"]) do
      for _, preset in pairs(preset_group) do
        if preset and preset.basic_settings and preset.basic_settings.autoplace_controls then
          preset.basic_settings.autoplace_controls[item_name] = nil
        end
        if preset and preset.advanced_settings
          and preset.advanced_settings.autoplace_settings
          and preset.advanced_settings.autoplace_settings.entity
          and preset.advanced_settings.autoplace_settings.entity.settings then
          preset.advanced_settings.autoplace_settings.entity.settings[item_name] = nil
        end
      end
    end
  end
end



-- data-final-fixes.lua
--data.raw.resource["crude-oil"] = nil