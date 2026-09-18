data:extend(
{
	{
		-- Properties
		stack_size = 1,											--								 :: ItemCountType 				| Count of items of the same name that can be stored in one inventory slot. Must be 1 when the "not-stackable" flag is set.
		icons = {												--						optional :: array[IconData]				| Can't be an empty array. 
			{
				icon = "__core__/graphics/empty.png",
				icon_size = 64,
				scale = 0.5
			}
		},
		icon = nil,												--						optional :: FileName					| Path to the icon file. Only loaded, and mandatory if icons is not defined.
		icon_size = 64,											--						optional :: SpriteSizeType				| The size of the square icon, in pixels.
		dark_background_icons = nil,							--						optional :: array[IconData]				| Can't be an empty array.
		dark_background_icon = nil,								--						optional :: FileName					| If this is set, it is used to show items in alt-mode instead of the normal item icon.
		dark_background_icon_size = 64,							--						optional :: SpriteSizeType				| The size of the square icon, in pixels.
		place_result = "",										--						optional :: EntityID					| Name of the EntityPrototype that can be built using this item.
		place_as_equipment_result = "",							--						optional :: EquipmentID	
		fuel_category = "",										--						optional :: FuelCategoryID				| Must exist when a nonzero fuel_value is defined.
		burnt_result = "",										--						optional :: ItemID						| The item that is the result when this item gets burned as fuel.
		spoil_result = nil, 									-- Requires Space Age	optional :: ItemID						| Only loaded if spoil_ticks is larger than 0.
		spoil_quality_min = nil,								-- Requires Space Age	optional :: QualityID					| Only loaded if spoil_ticks is larger than 0.
		spoil_quality_max = nil,								-- Requires Space Age	optional :: QualityID					| Only loaded if spoil_ticks is larger than 0.
		spoil_quality_change = 0,								-- Requires Space Age	optional :: int8						| Only loaded if spoil_ticks is larger than 0.
		plant_result = nil,										--						optional :: EntityID
		place_as_tile = nil,									--						optional :: PlaceAsTile
		pictures = nil,											--						optional :: SpriteVariations			| Used to give the item multiple different icons so that they look less uniform on belts.
		flags = nil,											--						optional :: ItemPrototypeFlags			| Specifies some properties of the item.
		spoil_ticks = 0,										-- Requires Space Age	optional :: uint32	
		quality_affects_spoil_ticks = true,						-- Requires Space Age	optional :: boolean						| Only loaded if spoil_ticks is larger than 0.
		fuel_value = "0J",										--						optional :: Energy						| Amount of energy the item gives when used as fuel.
		fuel_acceleration_multiplier = 1.0,						--						optional :: double						| Must be 0 or positive.
		fuel_top_speed_multiplier = 1.0,						--						optional :: double						| Must be 0 or positive.
		fuel_emissions_multiplier = 1.0,						--						optional :: double
		fuel_acceleration_multiplier_quality_bonus = 0.0,		--						optional :: double						| Additional fuel acceleration multiplier per quality level.
		fuel_top_speed_multiplier_quality_bonus = 0.0,			--						optional :: double						| Additional fuel top speed multiplier per quality level.
		weight = nil,											--						optional :: Weight						| The default weight is calculated automatically from recipes and falls back to UtilityConstants::default_item_weight.
		ingredient_to_weight_coefficient = 0.5,					--						optional :: double
		space_platform_request_priority = false,				--						optional :: boolean						| Used by space platforms to prioritize item requests and make sure there is enough space for priority items before requesting the rest.
		fuel_glow_color = nil,									--						optional :: Color						| Colors the glow of the burner energy source when this fuel is burned.
		open_sound = nil,										--						optional :: Sound
		close_sound = nil,										--						optional :: Sound
		pick_sound = nil,										--						optional :: Sound
		drop_sound = nil,										--						optional :: Sound
		inventory_move_sound = nil,								--						optional :: Sound
		default_import_location	= "nauvis",						--						optional :: SpaceLocationID
		color_hint = nil,										--						optional :: ColorHintSpecification		| Only used by hidden setting, support may be limited.
		has_random_tint = true, 								--						optional :: boolean
		spoil_to_trigger_result = nil,							-- Requires Space Age	optional :: SpoilToTriggerResult		| Only loaded if spoil_ticks is larger than 0.
		destroyed_by_dropping_trigger = nil,					--						optional :: Trigger						| The effect/trigger that happens when an item is destroyed by being dropped on a TilePrototype marked as destroying dropped items.
		rocket_launch_products = nil,							--						optional :: array[ItemProductPrototype]
		send_to_orbit_mode = "not-sendable",					--						optional :: SendToOrbitMode				| The way this item works when we try to send it to the orbit on its own.
		moved_to_hub_when_building = nil,						--						optional :: boolean						| Whether this item should be moved to the hub when space platform performs building, upgrade or deconstruction and is left with this item.
		random_tint_color = nil,								--						optional :: Color						| Randomly tints item instances on belts and in the world.
		spoil_level = 0,										--						optional :: uint8						| Used by Inserters with spoil priority.
		auto_recycle = true,									--						optional :: boolean						| Whether the item should be included in the self-recycling recipes automatically generated by the quality mod.
		lab_ignores_spoil_percent = false,						--						optional :: boolean
		science_capacity = 1.0,									--						optional :: double						| Used by labs.

		-- Inherited from Prototype
		factoriopedia_alternative = nil,						--						optional :: string						| The ID type corresponding to the prototype that inherits from this.
		custom_tooltip_fields = nil,							--						optional :: array[CustomTooltipField]	| Allows to add extra description items to the tooltip and Factoriopedia.   

		--Inherited from PrototypeBase
		type = "item",											--								 :: string						| Specifies the kind of prototype this is
		name = "item-name",										--								 :: string						| Unique textual identification of the prototype.
		order = "",												--						optional :: Order						| Used to order prototypes in inventory, recipes and GUIs.
		localised_name = nil,									--						optional :: LocalisedString				| Overwrites the name set in the locale file
		localised_description = nil,							--						optional :: LocalisedString				| Overwrites the description set in the locale file.
		factoriopedia_description = nil,						--						optional :: LocalisedString				| Provides additional description used in factoriopedia.
		subgroup = nil,											--						optional :: ItemSubGroupID				| The name of an ItemSubGroup.
		hidden  = false,										--						optional :: boolean
		hidden_in_factoriopedia = nil,							--						optional :: boolean
		parameter = false,										--						optional :: boolean						| Whether the prototype is a special type which can be used to parametrize blueprints and doesn't have other function.
		factoriopedia_simulation = nil							--						optional :: SimulationDefinition		| The simulation shown when looking at this prototype in the Factoriopedia GUI.
	}
})