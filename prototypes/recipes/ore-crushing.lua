data:extend({
    {
        type = "recipe",
        name = "hr-hematite-crushing",
        category = "crafting",
        enabled = false,
        energy_required = 2,
        ingredients = {
            {type="item", name="raw-hematite", amount=1},
        },
        results = {
            {type="item", name="crushed-hematite", amount=2}
        }
      },
      {
        type = "recipe",
        name = "hr-hematite-screening",
        category = "crafting",
        enabled = false,
        energy_required = 2,
        ingredients = {
            {type="item", name="crushed-hematite", amount=2},
        },
        results = {
            {type="item", name="lump-hematite", amount=2},
            {type="item", name="fines-hematite", amount=2},
        }
      },
  })