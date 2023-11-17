require "test_helper"

class LootTableTest < ActiveSupport::TestCase
  test "should sum probabilities of items" do
    table = LootTable.create(title: "My Table")
    item1 = LootItem.create(name: "Item 1", probability: 2, loot_table_id: table.id)
    item2 = LootItem.create(name: "Item 2", probability: 40, loot_table_id: table.id)
    item2 = LootItem.create(name: "Item 2", probability: 40, loot_table_id: table.id, always: true)
    assert table.possible_items.length == 2
    result = table.possible_probabilities()
    assert result == 42
  end

  test "roll selects an item" do
    table = LootTable.create(title: "My Table")
    item1 = LootItem.create(name: "Item 1", probability: 0, loot_table_id: table.id)
    item2 = LootItem.create(name: "Item 2", probability: 1, loot_table_id: table.id)
    roll = table.roll()
    assert roll.first.id == item2.id
  end

  test "always selects an always item" do
    table = LootTable.create(title: "My Table")
    item1 = LootItem.create(name: "Item 1", probability: 1, loot_table_id: table.id, always: true)
    item2 = LootItem.create(name: "Item 2", probability: 100, loot_table_id: table.id)
    300.times do
      assert table.roll().first.id == item1.id
    end
  end

  test "never selects a unique item twice" do
    table = LootTable.create(title: "My Table", count: 2)
    item1 = LootItem.create(name: "Item 1", probability: 1, loot_table_id: table.id)
    item2 = LootItem.create(name: "Item 2", probability: 1000, loot_table_id: table.id, unique: true)
    300.times do
      refute table.roll().collect(&:id) == [item2.id, item2.id]
    end
  end

  test "rolls on child tables of loot items" do
    parent = LootTable.create(title: "Parent Table", count: 1)
    child = LootTable.create(title: "Child Table", count: 1)
    item1 = LootItem.create(name: "Parent Item 1", probability: 1, loot_table_id: parent.id, inner_table_id: child.id)
    item2 = LootItem.create(name: "Child Item 1", probability: 1, loot_table_id: child.id)
    assert parent.roll().collect(&:id) == [item2.id]
  end
end
