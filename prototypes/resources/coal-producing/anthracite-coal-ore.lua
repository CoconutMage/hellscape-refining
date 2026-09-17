local resource_autoplace = require("resource-autoplace")

data:extend({
    {
        type = "autoplace-control",
        name = "anthracite-coal-ore",
        richness = true,
        category = "resource",
        order = "b-a"
    },
    {
        type = "resource",
        name = "anthracite-coal-ore",
        icon = "__hellscape-refining__/graphics/icons/ores/coal/anthracite-coal-ore.png",
        icon_size = 64,

        flags = {"placeable-neutral"},
        order = "a-b-a",

        minable = {
        mining_time = 1.0,
        result = "raw-anthracite-coal"
        },

        collision_box = {{-0.1, -0.1}, {0.1, 0.1}},
        selection_box = {{-0.5, -0.5}, {0.5, 0.5}},

        -- Patch visuals
        stage_counts = {15000, 8000, 4000, 2000, 1000, 500, 250, 125},
        stages = {
        sheet = {
            filename = "__hellscape-refining__/graphics/entity/anthracite-coal-ore/anthracite-coal-ore.png",
            priority = "extra-high",
            size = 64,
            frame_count = 8,
            variation_count = 8,
            -- optional tint, scale, etc.
        }
        },

        -- Worldgen
        autoplace = resource_autoplace.resource_autoplace_settings{
            name = "anthracite-coal-ore",
            order = "b-a",
            base_density = 8,
            base_spots_per_km2 = 1.2,
            has_starting_area_placement = true,
            regular_rq_factor_multiplier = 1.0
            },

        map_color = {0.7, 0.7, 0.8}
    }
})