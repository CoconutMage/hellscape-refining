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
    type = "item",
    name = "jaw-crusher-2",
    icons = {
      {
        icon = "__hellscape-refining__/graphics/icons/jaw-crusher.png",
        icon_size = 128
      },
    },
    subgroup = "hellscape-refining-building",--"angels-water-treatment-building",
    --order = "c[clarifier]",
    place_result = "jaw-crusher-2",
    stack_size = 10,
  },
  {
    type = "assembling-machine",
    name = "jaw-crusher-2",
    icons = {
      {
        icon = "__hellscape-refining__/graphics/icons/jaw-crusher.png",
        icon_size = 128,
      },
    },
    flags = { "placeable-neutral", "placeable-player", "player-creation" },
    minable = { mining_time = 1, result = "angels-clarifier" },
    max_health = 200,
    fast_replaceable_group = "jaw-crusher-2",
    corpse = "small-remnants",
    collision_box = {{ -1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{ -1.5, -1.5}, {1.5, 1.5}},
    crafting_categories = { "crushing" },
    module_slots = 4,
    allowed_effects = { "speed", "productivity", "pollution" },
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
    energy_source = {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = { pollution = 0.6 },
    },
    energy_usage = "30kW",
    circuit_wire_connection_points = drilling_rig_circuit_connector_definitions.points,
    circuit_connector_sprites = drilling_rig_circuit_connector_definitions.sprites,
    circuit_wire_max_distance = default_circuit_wire_max_distance,
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
    impact_category = "metal",
    repair_sound = { filename = "__base__/sound/manual-repair-simple.ogg" },
    open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
    close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
  },
})
