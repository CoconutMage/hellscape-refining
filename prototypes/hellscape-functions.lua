function hellscape.functions.add_crafting_category(crafting_machine_type, crafting_machine_name, crafting_category)
  if not data.raw[crafting_machine_type] then
    return
  end
  if not data.raw[crafting_machine_type][crafting_machine_name] then
    return
  end

  if type(crafting_category) == "table" then
    for _, category in pairs(crafting_category) do
      hellscape.functions.add_crafting_category(crafting_machine_type, crafting_machine_name, category)
    end
  end
  if not data.raw["recipe-category"][crafting_category] then
    return
  end

  local crafting_machine_prototype = data.raw[crafting_machine_type][crafting_machine_name]
  crafting_machine_prototype.crafting_categories = crafting_machine_prototype.crafting_categories or {}

  for _, category_name in pairs(crafting_machine_prototype.crafting_categories) do
    if category_name == crafting_category then
      return -- already present
    end
  end

  table.insert(crafting_machine_prototype.crafting_categories, crafting_category)

  if crafting_category ~= "angels-unused-machine" then
    hellscape.functions.remove_crafting_category(crafting_machine_type, crafting_machine_name, "angels-unused-machine")
  end
end

function hellscape.functions.remove_crafting_category(crafting_machine_type, crafting_machine_name, crafting_category)
  if not data.raw[crafting_machine_type] then
    return
  end
  if not data.raw[crafting_machine_type][crafting_machine_name] then
    return
  end

  local crafting_machine_categories = data.raw[crafting_machine_type][crafting_machine_name].crafting_categories
  if not crafting_machine_categories then
    return
  end

  if type(crafting_category) == "table" then
    for _, category in pairs(crafting_category) do
      hellscape.functions.remove_crafting_category(crafting_machine_type, crafting_machine_name, category)
    end
  end

  for category_index, category_name in pairs(crafting_machine_categories) do
    if category_name == crafting_category then
      table.remove(crafting_machine_categories, category_index)

      if next(crafting_machine_categories) then
        return
      else
        hellscape.functions.add_crafting_category(
          crafting_machine_type,
          crafting_machine_name,
          "angels-unused-machine"
        )
      end
    end
  end
end

local function box_equal(b1, b2)
  if not (b1 and b2) then
    return false
  end

  local function pos_equal(p1, p2)
    if not (p1 and p2) then
      return false
    end

    local p1x = p1.x or p1[1] or nil
    local p2x = p2.x or p2[1] or nil
    if not (p1x and p1x == p2x) then
      return false
    end

    local p1y = p1.y or p1[2] or nil
    local p2y = p2.y or p2[2] or nil

    return (p1y and p1y == p2y)
  end

  if not pos_equal(b1.left_top or b1[1], b2.left_top or b2[1]) then
    return false
  end
  return pos_equal(b1.right_bottom or b1[2], b2.right_bottom or b2[2])
end