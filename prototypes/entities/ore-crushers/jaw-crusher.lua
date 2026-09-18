local hit_effects = require("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")
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
    type = "assembling-machine",
    name = "jaw-crusher",
    icon = "__hellscape-refining__/graphics/icons/jaw-crusher.png",
    icon_size = 128,
    subgroup = "hellscape-refining-building",
    vector_to_place_result = {0.0, 1.7},
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.5, result = "jaw-crusher"},
    crafting_categories = {
        "crushing",
        --"hellscape-refining"
    },
    max_health = 200,
    heating_energy = "400kW",
    crafting_speed = 1,
    module_slots = 4,
    allowed_effects = { "speed", "productivity", "pollution" },
    corpse = "pumpjack-remnants",
    dying_explosion = "pumpjack-explosion",
    collision_box = {{ -1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{ -1.5, -1.5}, {1.5, 1.5}},
    -- damaged_trigger_effect = hit_effects.entity(),
    drawing_box = {{-1.6, -2.5}, {1.5, 1.6}},
    energy_source = {
        type = "electric",
        usage_priority = "secondary-input",
        emissions_per_minute = { pollution = 5 },
    },
    energy_usage = "300kW",
    module_slots = 2,
    resistances = {
        { type = "physical", percent = 50 },
        { type = "fire", percent = 95 },
        { type = "impact", percent = 80 },
    },
    monitor_visualization_tint = {r=78, g=173, b=255},
    base_render_layer = "lower-object-above-shadow",
    graphics_set = {
        animation = {
          layers = {
              {
              filename = "__hellscape-refining__/graphics/entity/jaw-crusher/jaw-crusher.png",
              width = 128,
              height = 128,
              frame_count = 1,
              animation_speed = 0.15,
              shift = { 0, 0 },
              scale = 0.75,
              },
          },
        },
        working_visualisations = { {
          animation = {
              layers = {
                  {
                  filename = "__hellscape-refining__/graphics/entity/jaw-crusher/jaw-crusher-anim.png",
                  width = 128,
                  height = 128,
                  frame_count = 4,
                  animation_speed = 0.15,
                  shift = { 0, 0 },
                  scale = 0.75,
                  },
              },
          },
        } }
      },
    damaged_trigger_effect = hit_effects.entity(),
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    idle_sound = { filename = "__base__/sound/idle1.ogg" },
    vehicle_impact_sound = sounds.generic_impact,
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