local resource_autoplace = require("resource-autoplace")

data:extend({
    {
        type = "autoplace-control",
        name = "copper-oxide-ore",
        richness = true,
        category = "resource",
        order = "b-a"
    },
    {
        type = "resource",
        name = "copper-oxide-ore",
        icon = "__hellscape-refining__/graphics/icons/temp-copper-oxide-ore.png",
        icon_size = 128,

        flags = {"placeable-neutral"},
        order = "a-b-a",

        minable = {
        mining_time = 1.0,
        result = "raw-copper-oxide"
        },

        collision_box = {{-0.1, -0.1}, {0.1, 0.1}},
        selection_box = {{-0.5, -0.5}, {0.5, 0.5}},

        -- Patch visuals
        stage_counts = {15000},
        stages = {
        sheet = {
            filename = "__hellscape-refining__/graphics/entity/temp-copper-oxide-ore.png",
            priority = "extra-high",
            size = 128,
            frame_count = 1,
            variation_count = 1,
            scale = 0.25,
            -- optional tint, scale, etc.
        }
        },

        -- Worldgen
        autoplace = resource_autoplace.resource_autoplace_settings{
            name = "copper-oxide-ore",
            order = "b-a",
            base_density = 8,
            base_spots_per_km2 = 1.2,
            has_starting_area_placement = true,
            regular_rq_factor_multiplier = 1.0
            },

        map_color = {0.7, 0.7, 0.8}
    }
})