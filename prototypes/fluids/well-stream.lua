data:extend({
  {
    type = "fluid",
    name = "well-stream",
    icon = "__hellscape-refining__/graphics/icons/fluids/well-stream.png",
    icon_size = 128,
    subgroup = "fluid",
    order = "z[drilling]-a[well-stream]",

    default_temperature = 25,
    max_temperature = 100,
    heat_capacity = "1kJ",

    base_color = {r=0.10, g=0.35, b=0.45},
    flow_color = {r=0.25, g=0.70, b=0.85},
  }
})