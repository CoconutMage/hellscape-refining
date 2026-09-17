local resource_autoplace = require("resource-autoplace")

-- Initialize autoplace (Factorio 2.0 / Space Age style)

local ap = resource_autoplace.resource_autoplace_settings
  {
    name = "oil-reservoir",
    order = "c", -- Other resources are "b"; oil won't get placed if something else is already there.
    base_density = 1,
    base_spots_per_km2 = 5,
    random_spot_size_minimum = 50,
    random_spot_size_maximum = 100, -- don't randomize spot size
    additional_richness = 1600, -- this increases the total everywhere, so base_density needs to be decreased to compensate
    has_starting_area_placement = true,
    regular_rq_factor_multiplier = 1
  }
ap.richness_expression = "1 + distance * 2"

data:extend({
  {
    type = "autoplace-control",
    name = "oil-reservoir",
    richness = true,
    category = "resource",
    order = "b-a"
  },
  {
    type = "resource",
    name = "oil-reservoir",
    icon = "__hellscape-refining__/graphics/icons/gas.png",
    icon_size = 64,

    flags = {"placeable-neutral"},
    category = "drilling-location",
    order = "a-b-z",

    highlight = true,

    infinite = false,
    minimum = 5,                     -- minimum yield
    normal = 5,                     -- typical yield
    resource_patch_search_radius = 12,

    localised_description = {"",
      "Underground reservoir marker.\n",
      "Place a Bore Drill to extract.\n",
      "Requires Drilling Fluid.\n",
      "Multiple wells share one reservoir."
    },

    custom_tooltip_fields =
    {
      { name={"", "Input"},  value={"", "[img=fluid/drilling-fluid] Drilling fluid"}, order=110 },
      { name={"", "Output"}, value={"", "[img=fluid/used-drilling-fluid] Used drilling fluid"}, order=111 },
      { name={"", "Notes"},  value={"", "Shared reservoir across connected patch"}, order=112 }
    },

    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},

    minable = {
      mining_time = 1,
      results =
      {
        {
          type = "fluid",
          name = "used-drilling-fluid",
          amount_min = 10,
          amount_max = 10,
          independent_probability = 1
        }
      },
      fluid_amount = 100,
      required_fluid = "drilling-fluid"
    },

    -- Autoplace (patch generation)
    autoplace = ap,

    -- Optional: add a map color / stage graphics like oil
    map_color = {0.78, 0.2, 0.77},
    map_grid = false,
    stage_counts = {0},
    stages = {
      sheet = {
        filename = "__hellscape-refining__/graphics/icons/drill-spot.png",
        priority = "extra-high",
        width = 32,
        height = 32,
        frame_count = 4,
        variation_count = 1,
        shift = {0, 0},
        scale = 1
      }
    }
  }
})