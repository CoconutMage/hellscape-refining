data:extend({
    {
        type = "recipe-category",
        name = "crushing"
    },
    {
        type = "recipe-category",
        name = "screening"
    },
    {
        type = "recipe",
        name = "hr-hematite-crushing",
        categories = {"crushing"},
        enabled = true,
        energy_required = 2,
        main_product = "crushed-hematite",
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
        categories = {"screening"},
        enabled = true,
        energy_required = 2,
        main_product = "lump-hematite",
        ingredients = {
            {type="item", name="crushed-hematite", amount=2},
        },
        results = {
            {type="item", name="lump-hematite", amount=2},
            {type="item", name="fines-hematite", amount=2},
        }
      },
  })