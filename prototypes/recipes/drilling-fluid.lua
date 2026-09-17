data:extend({
  {
    type = "recipe",
    name = "drilling-fluid",
    categories = {"chemistry"},
    enabled = false,
    energy_required = 2,
    ingredients = {
      {type="fluid", name="water", amount=50},
      {type="item", name="coal", amount=1},
      {type="item", name="stone", amount=1}
    },
    results = {
      {type="fluid", name="drilling-fluid", amount=50}
    }
  }
})