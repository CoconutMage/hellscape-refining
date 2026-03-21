local resource_autoplace = require("resource-autoplace")

data:extend({
  {
    type = "autoplace-control",
    name = "magnetite-ore",
    category = "resource",
    richness = true,
    order = "b-b"
  },
  {
    type = "resource",
    name = "magnetite-ore",
    icon = "__hellscape-refining__/graphics/icons/magnetite-ore.png",
    icon_size = 64,

    flags = {"placeable-neutral"},
    order = "a-b-a",

    minable = {
      mining_time = 1.0,
      result = "raw-magnetite"
    },

    collision_box = {{-0.1, -0.1}, {0.1, 0.1}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},

    -- Patch visuals
    stage_counts = {15000, 8000, 4000, 2000, 1000, 500, 250, 125},
    stages = {
      sheet = {
        filename = "__hellscape-refining__/graphics/entity/magnetite-ore/magnetite-ore.png",
        priority = "extra-high",
        size = 64,
        frame_count = 8,
        variation_count = 8,
        -- optional tint, scale, etc.
      }
    },

    -- Worldgen
    autoplace = resource_autoplace.resource_autoplace_settings
    {
      name = "magnetite-ore",
      order = "b-b",
      base_density = 6,
      base_spots_per_km2 = 0.9,
      has_starting_area_placement = false,
      regular_rq_factor_multiplier = 1.1
    },

    map_color = {0.5, 0.5, 0.6}
  }
})