data:extend({
	{
		name = "injection-recovery-well",
		type = "mining-drill",

		mining_speed = 1,
		resource_searching_radius = 0.49,
		max_health = 200,
		is_military_target = false,
		module_slots = 2,
		allowed_effects = { "speed", "productivity", "pollution" },
		resource_categories = {"uranite"},
		fluid_boxes_off_when_no_fluid_recipe = false,
		--collision_box = {{ -3, -3}, {3, 3}},
		--selection_box = {{ -3.1, -3.1}, {3.1, 3.1}},
		collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
		vector_to_place_result = {0, 0},
		energy_usage = "100kW",
		energy_source = {
			type = "electric",
			usage_priority = "secondary-input",
			emissions_per_minute = { pollution = 5 }
		},
		input_fluid_box = 
		{
			production_type = "input",
			pipe_covers = pipecoverspictures(),
			pipe_connections = {
				{ 
					flow_direction = "input", 
					direction = defines.direction.west, 
					position = {-1,1} 
				}
			},
			volume = 1000,
			filter = "isl-fluid"
		},
		output_fluid_box = 
		{
				production_type = "output",
				pipe_covers = pipecoverspictures(),
				pipe_connections = {
					{ 
						flow_direction = "output", 
						direction = defines.direction.east, 
						position = {1,-1} 
					}
				},
				volume = 1000,
				filter = "uranium-enriched-solution"
		}
	}
})