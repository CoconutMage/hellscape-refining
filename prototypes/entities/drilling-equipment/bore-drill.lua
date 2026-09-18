local hit_effects = require("__base__/prototypes/entity/hit-effects")
local sounds = require("__base__/prototypes/entity/sounds")
local futil = require("util")

drilling_rig_circuit_connector_definitions = circuit_connector_definitions.create_vector
(
  universal_connector_template,
  {
    { variation = 26, main_offset = futil.by_pixel(32, -3), shadow_offset = futil.by_pixel(32, -3), show_shadow = true },
    { variation = 26, main_offset = futil.by_pixel(32, -3), shadow_offset = futil.by_pixel(32, -3), show_shadow = true },
    { variation = 26, main_offset = futil.by_pixel(32, -3), shadow_offset = futil.by_pixel(32, -3), show_shadow = true },
    { variation = 26, main_offset = futil.by_pixel(32, -3), shadow_offset = futil.by_pixel(32, -3), show_shadow = true }
  }
)

data:extend({
  {
    type = "mining-drill",
    name = "bore-drill",
    icon = "__hellscape-refining__/graphics/icons/gas-extractor.png",
    icon_size = 128,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.5, result = "bore-drill"},
    resource_categories = {"drilling-location"},
    max_health = 200,
    corpse = "pumpjack-remnants",
    dying_explosion = "pumpjack-explosion",
    collision_box = {{ -1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{ -1.5, -1.5}, {1.5, 1.5}},
    -- damaged_trigger_effect = hit_effects.entity(),
    drawing_box = {{-1.6, -2.5}, {1.5, 1.6}},
    energy_source =
    {
      type = "electric",
      emissions_per_minute = { pollution = 10 },
      usage_priority = "secondary-input"
    },
    input_fluid_box = {
      production_type = "input",
      pipe_covers = pipecoverspictures(),
      pipe_connections ={
        {
          direction = defines.direction.south,
          positions = { {0, 1}, {-1, 0}, {0, -1}, {1, 0} }
        }
      },
      volume = 100,
      filter = "drilling-fluid" -- strongly recommended, prevents “wrong fluid filled” edge cases
    },
    output_fluid_box =
    {
      volume = 1000,
      pipe_covers = pipecoverspictures(),
      pipe_connections =
      {
        {
          direction = defines.direction.north,
          positions = { {0, -1}, {1, 0}, {0, 1}, {-1, 0} }
        }
      }
    },
    energy_usage = "90kW",
    mining_speed = 1,
    resource_searching_radius = 0.49,
    vector_to_place_result = {0, 0},
    module_slots = 2,
    radius_visualisation_picture =
    {
      filename = "__base__/graphics/entity/pumpjack/pumpjack-radius-visualization.png",
      width = 12,
      height = 12
    },
    monitor_visualization_tint = {r=78, g=173, b=255},
    base_render_layer = "lower-object-above-shadow",
    base_picture = {
      north = {
        filename = "__hellscape-refining__/graphics/entity/gas-extractor-base-n.png",
        priority = "extra-high",
        width = 175,
        height = 179,
        scale = 0.5,
        shift = futil.by_pixel(0, -4),
      },
      south = {
        filename = "__hellscape-refining__/graphics/entity/gas-extractor-base-s.png",
        priority = "extra-high",
        width = 175,
        height = 149,
        scale = 0.5,
        shift = futil.by_pixel(0, 13),
      },
      east = {
        filename = "__hellscape-refining__/graphics/entity/gas-extractor-base-e.png",
        priority = "extra-high",
        width = 207,
        height = 129,
        scale = 0.5,
        shift = futil.by_pixel(8, 8),
      },
      west = {
        filename = "__hellscape-refining__/graphics/entity/gas-extractor-base-w.png",
        priority = "extra-high",
        width = 207,
        height = 129,
        scale = 0.5,
        shift = futil.by_pixel(-8, 8),
      },
    },
    graphics_set = {
      animation = {
        north = {
          layers = {
            {
              filename = "__hellscape-refining__/graphics/entity/gas-extractor-animated.png",
              priority = "extra-high",
              width = 267,
              height = 604,
              scale = 0.33, -- just under 1/3, for height ~200. Check why height is 604 and not 600
              frame_count = 100,
              line_length = 8,
              animation_speed = 0.5,
              shift = futil.by_pixel(0, -60),
            },
            {
              stripes = futil.multiplystripes(100, { {
                filename = "__hellscape-refining__/graphics/entity/gas-extractor-shadow.png",
                width_in_frames = 1,
                height_in_frames = 1,
              } }),
              priority = "extra-high",
              width = 331,
              height = 64,
              draw_as_shadow = true,
              frame_count = 100,
              animation_speed = 0.5,
              shift = futil.by_pixel(119, 8),
            },
          },
        }
      }
    },
    vehicle_impact_sound = data.raw["mining-drill"]["pumpjack"].vehicle_impact_sound,
    open_sound = data.raw["mining-drill"]["pumpjack"].open_sound,
    close_sound = data.raw["mining-drill"]["pumpjack"].close_sound,
    working_sound =
    {
      sound =
      {
        {
          filename = "__base__/sound/pumpjack.ogg",
          volume = 0.7
        },
      },
      max_sounds_per_type = 3,
      audible_distance_modifier = 0.6,
      fade_in_ticks = 4,
      fade_out_ticks = 10
    },
    fast_replaceable_group = "pumpjack",

    circuit_wire_connection_points = drilling_rig_circuit_connector_definitions.points,
    circuit_connector_sprites = drilling_rig_circuit_connector_definitions.sprites,
    circuit_wire_max_distance = default_circuit_wire_max_distance
  }
})