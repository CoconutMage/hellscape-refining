data:extend({
  {
    type = "fluid",
    name = "drilling-fluid",
    icon = "__hellscape-refining__/graphics/icons/fluids/drilling-fluid.png",
    icon_size = 128,
    subgroup = "fluid",
    order = "z[drilling]-a[drilling-fluid]",

    default_temperature = 25,

    base_color = {r=0.10, g=0.35, b=0.45},
    flow_color = {r=0.25, g=0.70, b=0.85},
  },
  {
    type = "fluid",
    name = "used-drilling-fluid",
    icon = "__hellscape-refining__/graphics/icons/fluids/used-drilling-fluid.png",
    icon_size = 128,
    subgroup = "fluid",
    order = "z[drilling]-b[used-drilling-fluid]",

    default_temperature = 25,

    base_color = {r=0.25, g=0.20, b=0.10},
    flow_color = {r=0.65, g=0.55, b=0.25},
  }
})