data:extend({
{
  type = "furnace",
  name = "oil-gas-separator",
  icon = "__hellscape-refining__/graphics/entity/oil-gas-separator.png",
  icon_size = 224,

  flags = {"placeable-neutral","placeable-player","player-creation"},
  minable = {mining_time = 0.5, result = "oil-gas-separator"},
  max_health = 350,

  collision_box = {{-2.2,-2.2},{2.2,2.2}},
  selection_box = {{-2.5,-2.5},{2.5,2.5}},

  crafting_categories = {"oil-gas-separation"},
  crafting_speed = 1,

  energy_source =
  {
    type = "electric",
    emissions_per_minute = {pollution = 4},
    usage_priority = "secondary-input"
  },

  energy_usage = "250kW",

  result_inventory_size = 0,
  source_inventory_size = 0,

  fluid_boxes =
  {
    -- INPUT WELL STREAM
    {
      production_type = "input",
      pipe_covers = pipecoverspictures(),
      pipe_connections =
      {
        {flow_direction = "input", direction = defines.direction.north, position = {0,-2}}
      },
      volume = 200,
      filter = "well-stream"
    },

    -- OUTPUT GAS
    {
      production_type = "output",
      pipe_covers = pipecoverspictures(),
      pipe_connections =
      {
        {flow_direction = "output", direction = defines.direction.east, position = {2,0}}
      },
      volume = 200,
      filter = "water"
    },

    -- OUTPUT CONDENSATE
    {
      production_type = "output",
      pipe_covers = pipecoverspictures(),
      pipe_connections =
      {
        {flow_direction = "output", direction = defines.direction.south, position = {0,2}}
      },
      volume = 200,
      filter = "sulfuric-acid"
    },

    -- OUTPUT STABILIZED OIL
    {
      production_type = "output",
      pipe_covers = pipecoverspictures(),
      pipe_connections =
      {
        {flow_direction = "output", direction = defines.direction.west, position = {-2,0}}
      },
      volume = 200,
      filter = "crude-oil"
    }
  },

  graphics_set = {
      animation = {
        layers = {
          {
            filename = "__hellscape-refining__/graphics/entity/oil-gas-separator.png",
            width = 224,
            height = 224,
            frame_count = 1,
            shift = { 0, 0 },
          },
          -- {
          -- filename = "__angelspetrochemgraphics__/graphics/entity/separator/5x5-overlay.png",
          -- tint = {r = 0.8, g = 0, b = 0},
          -- width = 160,
          -- height = 160,
          -- frame_count = 1,
          -- line_length = 4,
          -- shift = {0, 0},
          -- animation_speed = 0.5
          -- },
        },
      },
    },

  working_sound =
  {
    sound = {filename = "__base__/sound/chemical-plant.ogg", volume = 0.7},
    fade_in_ticks = 4,
    fade_out_ticks = 20
  }
}
})