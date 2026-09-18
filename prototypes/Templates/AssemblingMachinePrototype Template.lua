data:extend(
{
	{
		-- Properties
		fixed_recipe = "",											--						optional :: RecipeID																| The preset recipe of this machine.
		fixed_quality = nil,										--						optional :: QualityID																| Only loaded if fixed_recipe is defined.
		gui_title_key = "",											--						optional :: string																	| The locale key of the title of the recipe selection GUI that is shown when the player opens the assembling machine.
		circuit_wire_max_distance = 0,								--						optional :: double																	| The maximum circuit wire distance for this entity.
		draw_copper_wires = true,									--						optional :: boolean	
		draw_circuit_wires = true,									--						optional :: boolean	
		default_recipe_finished_signal = nil,						--						optional :: SignalIDConnector	
		default_working_signal = nil,								--						optional :: SignalIDConnector	
		ingredient_count = 65535,									--						optional :: uint16																	| Sets the maximum number of item ingredients this machine can craft with.
		max_item_product_count = 65535,								--						optional :: uint16	
		circuit_connector = nil,									--						optional :: {CircuitConnectorDefinition, CCD, CCD, CCD}	
		circuit_connector_flipped = nil,							--						optional :: {CircuitConnectorDefinition, CCD, CCD, CCD}	
		fluid_boxes_off_when_no_fluid_recipe = false,				--						optional :: boolean	
		disabled_when_recipe_not_researched = nil,					--						optional :: boolean																	| Defaults to true if fixed_recipe is not given.

		-- Inherited from CraftingMachinePrototype
		quality_affects_energy_usage = false,						--						optional :: boolean																	| When set, QualityPrototype::crafting_machine_energy_usage_multiplier will be applied to energy_usage.
		energy_usage = "1W",										--								 :: Energy																	| Sets how much energy this machine uses while crafting.
		crafting_speed = 1.0,										--								 :: double																	| How fast this crafting machine can craft.
		crafting_categories = {"crafting"},							--								 :: array[RecipeCategoryID]													| A list of recipe categories this crafting machine can use.
		energy_source = {type = "void"},							--								 :: EnergySource															| Defines how the crafting machine is powered.
		fluid_boxes = nil,											--						optional :: array[FluidBox]															| The crafting machine's fluid boxes.
		effect_receiver = nil,										--						optional :: EffectReceiver	
		module_slots = 0,											--						optional :: ItemStackIndex															| The number of module slots in this machine.
		quality_affects_module_slots = false,						--						optional :: boolean																	| If set, QualityPrototype::crafting_machine_module_slots_bonus will be added to module slots count.
		allowed_effects = {},										--						optional :: EffectTypeLimitation													| Sets the modules and beacon effects that are allowed to be used on this machine.
		allowed_module_categories = nil,							--						optional :: array[ModuleCategoryID]													| Sets the module categories that are allowed to be inserted into this machine.
		show_recipe_icon = true,									--						optional :: boolean																	| Whether the "alt-mode icon" should be drawn at all.
		return_ingredients_on_change = true,						--						optional :: boolean																	| Controls whether the ingredients of an in-progress recipe are destroyed when mining the machine/changing the recipe.
		draw_entity_info_icon_background = true,					--						optional :: boolean																	| Whether the "alt-mode icon" should have a black background.
		match_animation_speed_to_activity = true,					--						optional :: boolean																	| Whether the speed of the animation and working visualization should be based on the machine's speed (boosted or slowed by modules).
		show_recipe_icon_on_map = true,								--						optional :: boolean																	| Whether the recipe icon should be shown on the map.
		fast_transfer_modules_into_module_slots_only = false,		--						optional :: boolean	
		ignore_output_full = false,									--						optional :: boolean	
		graphics_set = nil,											--						optional :: CraftingMachineGraphicsSet	
		graphics_set_flipped = nil,									--						optional :: CraftingMachineGraphicsSet	
		perceived_performance = nil,								--						optional :: PerceivedPerformance													| Affects animation speed.
		production_health_effect = nil,								--						optional :: ProductionHealthEffect	
		trash_inventory_size = nil,									--						optional :: ItemStackIndex	
		vector_to_place_result = nil,								--						optional :: Vector	
		use_mirroring = nil,										--						optional :: boolean																	| Defaults to true if vector_to_place_result is given.
		crafting_speed_quality_multiplier = nil,					--						optional :: dictionary[QualityID → double]											| Each value must be >= 0.01.
		module_slots_quality_bonus = nil,							--						optional :: dictionary[QualityID → ItemStackIndex]									| If value is not provided for a quality, then QualityPrototype::crafting_machine_module_slots_bonus will be used as a module slots bonus instead.
		energy_usage_quality_multiplier = nil,						--						optional :: dictionary[QualityID → double]											| Each value must be >= 0.01.

		-- Inherited from EntityWithOwnerPrototype
		is_military_target = false,									--						optional :: boolean																	| Whether this prototype should be a high priority target for enemy forces.
		allow_run_time_change_of_is_military_target = false,		--						optional :: boolean																	| If this is true, this entity's is_military_target property can be changed during runtime (on the entity, not on the prototype itself).
		quality_indicator_shift = nil,								--						optional :: Vector																	| The shift from the bottom left corner of the selection box.
		quality_indicator_scale = nil,								--						optional :: double																	| The default scale is based on the tile distance of the shorter dimension.

		-- Inherited from EntityWithHealthPrototype
		max_health = 10,											--						optional :: float																	| The unit health can never go over the maximum.
		healing_per_tick = 0,										--						optional :: float																	| The amount of health automatically regenerated per tick.
		repair_speed_modifier = 1,									--						optional :: float																	| Multiplier of RepairToolPrototype::speed for this entity prototype.
		dying_explosion = nil,										--						optional :: ExplosionDefinition or array[ExplosionDefinition]																	| The entities that are spawned in place of this one when it dies.
		dying_trigger_effect = nil,									--						optional :: TriggerEffect	
		damaged_trigger_effect = nil,								--						optional :: TriggerEffect	
		loot = nil,													--						optional :: array[ItemProductPrototype]												| The loot is dropped on the ground when the entity is killed.
		resistances = nil,											--						optional :: array[Resistance]														| See damage.
		attack_reaction = nil,										--						optional :: AttackReactionItem or array[AttackReactionItem]	
		repair_sound = nil,											--						optional :: Sound																	| Played when this entity is repaired with a RepairToolPrototype.
		alert_when_damaged = true,									--						optional :: boolean	
		hide_resistances = true,									--						optional :: boolean																	| Whether the resistances of this entity should be hidden in the entity tooltip.
		create_ghost_on_death = true,								--						optional :: boolean	
		random_corpse_variation = false,							--						optional :: boolean	
		integration_patch_render_layer = "lower-object",			--						optional :: RenderLayer																| May also be defined inside graphics_set instead of directly in the entity prototype.
		corpse = nil,												--						optional :: EntityID or array[EntityID]												| Specifies the names of the CorpsePrototype to be used when this entity dies.
		integration_patch = nil,									--						optional :: Sprite4Way																| May also be defined inside graphics_set instead of directly in the entity prototype.
		overkill_fraction = 0.05,									--						optional :: float																	| Fraction of health by which predicted damage must be exceeded before entity is considered as "predicted to die" causing turrets (and others) to stop shooting more projectiles.
		
		-- Inherited from EntityPrototype
		icons = nil,												--						optional :: array[IconData]															| This will be used in the electric network statistics, editor building selection, and the bonus gui.
		icon = nil,													--						optional :: FileName																| Path to the icon file.
		icon_size = 64,												--						optional :: SpriteSizeType															| The size of the square icon, in pixels.
		collision_box = {{0, 0}, {0, 0}},							--						optional :: BoundingBox																| Specification of the entity collision boundaries.
		collision_mask = nil,										--						optional :: CollisionMaskConnector													| Defaults to the mask from UtilityConstants::default_collision_masks when indexed by the entity type.
		map_generator_bounding_box = nil,							--						optional :: BoundingBox																| Used instead of the collision box during map generation.
		selection_box = {{0, 0}, {0, 0}},							--						optional :: BoundingBox																| Specification of the entity selection area.
		drawing_box_vertical_extension = 0.0,						--						optional :: double																	| Specification of extra vertical space needed to see the whole entity in GUIs.
		sticker_box = nil,											--						optional :: BoundingBox																| Used to specify the area where the sticker animation can appear for entities that can have stickers on them.
		hit_visualization_box = {{0, 0}, {0, 0}},					--						optional :: BoundingBox																| Where beams should hit the entity.
		trigger_target_mask = nil,									--						optional :: TriggerTargetMask														| Defaults to the mask from UtilityConstants::default_trigger_target_mask_by_type.
		flags = nil,												--						optional :: EntityPrototypeFlags	
		tile_buildability_rules = nil,								--						optional :: array[TileBuildabilityRule]	
		minable = nil,												--						optional :: MinableProperties														| The item given to the player when they mine the entity and other properties relevant to mining this entity.
		surface_conditions = nil,									-- Requires Space Age	optional :: array[SurfaceCondition]	
		deconstruction_alternative = nil,							--						optional :: EntityID																| Used to merge multiple entities into one entry in the deconstruction planner.
		selection_priority = 50,									--						optional :: uint8																	| The entity with the higher number is selectable before the entity with the lower number.
		build_grid_size = 1,										--						optional :: uint8																	| Supported values are 1 (for 1x1 grid) and 2 (for 2x2 grid, like rails).
		remove_decoratives = "automatic",							--						optional :: "automatic" or "true" or "false"										| Whether this entity should remove decoratives that collide with it when this entity is built.
		emissions_per_second = nil,									--						optional :: dictionary[AirbornePollutantID → double]								| Amount of emissions created (positive number) or cleaned (negative number) every second by the entity.
		shooting_cursor_size = nil,									--						optional :: double																	| The cursor size used when shooting at this entity.
		created_smoke = nil,										--						optional :: CreateTrivialSmokeEffectItem											| The smoke that is shown when the entity is placed.
		working_sound = nil,										--						optional :: WorkingSound															| Will also work on entities that don't actually do work.
		created_effect = nil,										--						optional :: Trigger																	| The effect/trigger that happens when the entity is placed.
		build_sound = nil,											--						optional :: Sound	
		mined_sound = nil,											--						optional :: Sound	
		mining_sound = nil,											--						optional :: Sound	
		rotated_sound = nil,										--						optional :: Sound	
		ghost_build_sound = nil,									--						optional :: Sound	
		impact_category = "default",								--						optional :: string																	| Name of a ImpactCategory.
		open_sound = nil,											--						optional :: Sound	
		close_sound = nil,											--						optional :: Sound	
		placeable_position_visualization = nil,						--						optional :: Sprite	
		radius_visualisation_specification = nil,					--						optional :: RadiusVisualisationSpecification	
		stateless_visualisation = nil,								--						optional :: StatelessVisualisation or array[StatelessVisualisation]	
		draw_stateless_visualisations_in_ghost = false,				--						optional :: boolean	
		alert_icon_shift = nil,										--						optional :: Vector	
		alert_icon_scale = nil,										--						optional :: float	
		fast_replaceable_group = "",								--						optional :: string																	| This allows you to replace an entity that's already placed, with a different one in your inventory.
		next_upgrade = nil,											--						optional :: EntityID																| Name of the entity that will be automatically selected as the upgrade of this entity when using the upgrade planner without configuration.
		protected_from_tile_building = true,						--						optional :: boolean																	| When this is true, this entity prototype should be included during tile collision checks with tiles that have TilePrototype::check_collision_with_entities set to true.
		show_fluid_visualization_when_in_cursor = false,			--						optional :: boolean																	| When this is true, fluid pipelines will be visualized when this entity is held in the cursor.
		tall = false,												--						optional :: boolean																	| When this is true, this entity prototype will be translucent and unselectable when "Hide tall entities" mode is active.
		heating_energy = "0W",										-- Requires Space Age	optional :: Energy																	| This entity can freeze if heating_energy is larger than zero.
		allow_copy_paste = true,									--						optional :: boolean	
		selectable_in_game = true,									--						optional :: boolean	
		placeable_by = nil,											--						optional :: ItemToPlace or array[ItemToPlace]										| Item that when placed creates this entity.
		remains_when_mined = nil,									--						optional :: EntityID or array[EntityID]												| The entity that remains when this one is mined, deconstructed or fast-replaced.
		additional_pastable_entities = nil,							--						optional :: array[EntityID]															| Names of the entity prototypes this entity prototype can be pasted on to in addition to the standard supported types.
		tile_width = nil,											--						optional :: int32																	| Used to determine how the center of the entity should be positioned when building (unless the off-grid flag is specified).
		tile_height = nil,											--						optional :: int32	
		diagonal_tile_grid_size = nil,								--						optional :: TilePosition	
		autoplace = nil,											--						optional :: AutoplaceSpecification													| Used to specify the rules for placing this entity during map generation.
		map_color = nil,											--						optional :: Color	
		friendly_map_color = nil,									--						optional :: Color	
		enemy_map_color = nil,										--						optional :: Color	
		water_reflection = nil,										--						optional :: WaterReflectionDefinition												| May also be defined inside graphics_set instead of directly in the entity prototype.
		ambient_sounds_group = nil,									--						optional :: EntityID	
		ambient_sounds = nil,										--						optional :: WorldAmbientSoundDefinition or array[WorldAmbientSoundDefinition]	
		icon_draw_specification = nil,								--						optional :: IconDrawSpecification													| Used to specify where and how the alt-mode icons should be drawn.
		icons_positioning = nil,									--						optional :: array[IconSequencePositioning]

		-- Inherited from Prototype
		factoriopedia_alternative = nil,							--						optional :: string																	| The ID type corresponding to the prototype that inherits from this.
		custom_tooltip_fields = nil,								--						optional :: array[CustomTooltipField]												| Allows to add extra description items to the tooltip and Factoriopedia.   

		--Inherited from PrototypeBase
		type = "assembling-machine",								--								 :: string																	| Specifies the kind of prototype this is
		name = "assembling-machine-name",							--								 :: string																	| Unique textual identification of the prototype.
		order = nil,												--						optional :: Order																	| Used to order prototypes in inventory, recipes and GUIs.
		localised_name = nil,										--						optional :: LocalisedString															| Overwrites the name set in the locale file
		localised_description = nil,								--						optional :: LocalisedString															| Overwrites the description set in the locale file.
		factoriopedia_description = nil,							--						optional :: LocalisedString															| Provides additional description used in factoriopedia.
		subgroup = nil,												--						optional :: ItemSubGroupID															| The name of an ItemSubGroup.
		hidden  = false,											--						optional :: boolean
		hidden_in_factoriopedia = nil,								--						optional :: boolean
		parameter = false,											--						optional :: boolean																	| Whether the prototype is a special type which can be used to parametrize blueprints and doesn't have other function.
		factoriopedia_simulation = nil								--						optional :: SimulationDefinition													| The simulation shown when looking at this prototype in the Factoriopedia GUI.
	}
})