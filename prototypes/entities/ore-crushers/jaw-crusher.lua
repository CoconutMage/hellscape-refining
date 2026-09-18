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

data:extend(
{
	{
		type = "assembling-machine",
		name = "jaw-crusher",
		--subgroup = "hellscape-refining-entity-crusher",
		subgroup = "hellscape-refining-building",
		hidden  = false,
		parameter = false,
		draw_copper_wires = true,
		draw_circuit_wires = true,
		fluid_boxes_off_when_no_fluid_recipe = false,
		quality_affects_energy_usage = false,
		energy_usage = "300kW",
		crafting_speed = 1.0,
		crafting_categories = {"crushing"},
		energy_source = {
			type = "electric",
			usage_priority = "secondary-input",
			emissions_per_minute = { pollution = 5 }
		},
		module_slots = 4,
		quality_affects_module_slots = false,
		allowed_effects = { "speed", "productivity", "pollution" },
		show_recipe_icon = true,
		return_ingredients_on_change = true,
		draw_entity_info_icon_background = true,
		match_animation_speed_to_activity = true,
		show_recipe_icon_on_map = true,
		fast_transfer_modules_into_module_slots_only = false,
		ignore_output_full = false,
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
		vector_to_place_result = {0.0, 1.7},
		is_military_target = false,
		allow_run_time_change_of_is_military_target = false,
    max_health = 200,
		healing_per_tick = 0,
		repair_speed_modifier = 1,
		dying_explosion = "pumpjack-explosion",
		damaged_trigger_effect = hit_effects.entity(),
		resistances = { 
			{type = "physical", percent = 50 },
			{ type = "fire", percent = 95 },
			{ type = "impact", percent = 80 }
		},
		alert_when_damaged = true,
		hide_resistances = true,
		create_ghost_on_death = true,
		random_corpse_variation = false,
		integration_patch_render_layer = "lower-object",
		corpse = "pumpjack-remnants",
		overkill_fraction = 0.05,
		icon = "__hellscape-refining__/graphics/icons/jaw-crusher.png",
		icon_size = 128,
		collision_box = {{ -1.2, -1.2}, {1.2, 1.2}},
		selection_box = {{ -1.5, -1.5}, {1.5, 1.5}},
		-----------------------------
		-- Drawing box not in prototype
		drawing_box = {{-1.6, -2.5}, {1.5, 1.6}},
		-- Also not in prototype
		monitor_visualization_tint = {r=78, g=173, b=255},
		-- Also not in prototype
		base_render_layer = "lower-object-above-shadow",
		-- Also not in prototype
		{ filename = "__base__/sound/idle1.ogg" },
		-- Also not in prototype
		vehicle_impact_sound = sounds.generic_impact,
		-- Also not in prototype
		circuit_wire_connection_points = drilling_rig_circuit_connector_definitions.points,
    circuit_connector_sprites = drilling_rig_circuit_connector_definitions.sprites,
    circuit_wire_max_distance = default_circuit_wire_max_distance,
		-----------------------------
		drawing_box_vertical_extension = 0.0,
		hit_visualization_box = {{0, 0}, {0, 0}},
		flags = {"placeable-neutral", "player-creation"},
		minable = {mining_time = 0.5, result = "jaw-crusher"},
		selection_priority = 50,
		build_grid_size = 1,
		remove_decoratives = "automatic",
		working_sound = {
      sound = {
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
		impact_category = "default",
		open_sound = sounds.machine_open,
		close_sound = sounds.machine_close,
		draw_stateless_visualisations_in_ghost = false,
		fast_replaceable_group = "pumpjack",
		protected_from_tile_building = true,
		show_fluid_visualization_when_in_cursor = false,
		tall = false,
		heating_energy = "400kW",
		allow_copy_paste = true,
		selectable_in_game = true,
	}
})