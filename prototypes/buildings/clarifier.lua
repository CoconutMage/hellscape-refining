circuit_connector_definitions["angels-clarifier"] =
  circuit_connector_definitions.create_vector(universal_connector_template, {
    {
      variation = 6,
      main_offset = util.by_pixel(67, 63),
      shadow_offset = util.by_pixel(67, 63),
      show_shadow = true,
    },
    {
      variation = 6,
      main_offset = util.by_pixel(67, 63),
      shadow_offset = util.by_pixel(67, 63),
      show_shadow = true,
    },
    {
      variation = 6,
      main_offset = util.by_pixel(67, 63),
      shadow_offset = util.by_pixel(67, 63),
      show_shadow = true,
    },
    {
      variation = 6,
      main_offset = util.by_pixel(67, 63),
      shadow_offset = util.by_pixel(67, 63),
      show_shadow = true,
    },
  })

data:extend({
  {
    type = "item",
    name = "angels-clarifier",
    icons = {
      {
        icon = "__hellscape-refining__/graphics/icons/ores/iron/hematite-raw.png",
        icon_size = 64
      },
    },
    subgroup = "angels-water-treatment-building",
    order = "c[clarifier]",
    place_result = "angels-clarifier",
    stack_size = 10,
  },
  {
    type = "furnace",
    name = "angels-clarifier",
    icons = {
      {
        icon = "__hellscape-refining__/graphics/icons/ores/iron/hematite-raw.png",
        icon_size = 64
      },
    },
    flags = { "placeable-neutral", "placeable-player", "player-creation" },
    minable = { mining_time = 1, result = "angels-clarifier" },
    max_health = 100,
    fast_replaceable_group = "angels-clarifier",
    corpse = "small-remnants",
    collision_box = { { -2.4, -2.4 }, { 2.4, 2.4 } },
    selection_box = { { -2.5, -2.5 }, { 2.5, 2.5 } },
    crafting_categories = { "angels-water-void" },
    module_slots = 2,
    allowed_effects = { "consumption", "speed", "pollution" },
    result_inventory_size = 0,
    crafting_speed = 2,
    source_inventory_size = 0,
    show_recipe_icon = false,
    resistances = {
      {
        type = "fire",
        percent = 80,
      },
      {
        type = "explosion",
        percent = 30,
      },
    },
    fluid_boxes = {
      {
        production_type = "input",
        pipe_covers = pipecoverspictures(),
        volume = 1000,
        pipe_connections = { { flow_direction = "input", position = { 0, 2 }, direction = defines.direction.south } },
      },
    },
    energy_source = {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = { pollution = 0.6 },
    },
    energy_usage = "30kW",
    circuit_connector = circuit_connector_definitions["angels-clarifier"],
    circuit_wire_max_distance = default_circuit_wire_max_distance,
    graphics_set = {
    },
    impact_category = "metal",
    repair_sound = { filename = "__base__/sound/manual-repair-simple.ogg" },
    open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
    close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
  },
})
