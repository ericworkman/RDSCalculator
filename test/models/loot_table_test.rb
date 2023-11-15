require "test_helper"

class LootTableTest < ActiveSupport::TestCase
  test "roll selects an item" do
    table = LootTable.create(title: "My Table")
    item1 = LootItem.create(name: "Item 1", probability: 0, loot_table_id: table.id)
    item2 = LootItem.create(name: "Item 2", probability: 1, loot_table_id: table.id)
    roll = table.roll()
    assert roll.id == item2.id
  end
end
