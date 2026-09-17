data:extend({
    {
    type = "recipe",
    name = "separate-well-stream",
    categories = {"oil-gas-separation"},
    energy_required = 2,

    icon = "__hellscape-refining__/graphics/entity/oil-gas-separator.png",
    icon_size = 64,

    ingredients =
    {
        {type="fluid", name="well-stream", amount=50, minimum_temperature=45, maximum_temperature=50, fluidbox_index = 1}
    },

    results =
    {
        {type="fluid", name="water", amount=25, fluidbox_index = 1},
        {type="fluid", name="sulfuric-acid", amount=10, fluidbox_index = 2},
        {type="fluid", name="crude-oil", amount=15, fluidbox_index = 3}
    },

    main_product = "",
    allow_decomposition = false,
    enabled = true
    },
    {
    type = "recipe",
    name = "separate-well-stream-hot",
    categories = {"oil-gas-separation"},
    energy_required = 2,

    icon = "__hellscape-refining__/graphics/entity/oil-gas-separator.png",
    icon_size = 64,

    ingredients =
    {
        {type="fluid", name="well-stream", amount=50, minimum_temperature=50, maximum_temperature=60, fluidbox_index = 1}
    },

    results =
    {
        {type="fluid", name="water", amount=100, fluidbox_index = 1},
        {type="fluid", name="sulfuric-acid", amount=100, fluidbox_index = 2},
        {type="fluid", name="crude-oil", amount=150, fluidbox_index = 3}
    },

    main_product = "",
    allow_decomposition = false,
    enabled = true
    }
})