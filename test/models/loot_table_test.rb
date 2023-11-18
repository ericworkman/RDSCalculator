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
    assert roll.first.name == item2.name
  end

  test "always selects an always item" do
    table = LootTable.create(title: "My Table")
    item1 = LootItem.create(name: "Item 1", probability: 1, loot_table_id: table.id, always: true)
    item2 = LootItem.create(name: "Item 2", probability: 100, loot_table_id: table.id)
    300.times do
      assert table.roll().first.name == item1.name
    end
  end

  test "never selects a unique item twice" do
    table = LootTable.create(title: "My Table", count: 2)
    item1 = LootItem.create(name: "Item 1", probability: 1, loot_table_id: table.id)
    item2 = LootItem.create(name: "Item 2", probability: 1000, loot_table_id: table.id, unique: true)
    300.times do
      refute table.roll().collect(&:name) == [item2.name, item2.name]
    end
  end

  test "rolls on child tables of loot items" do
    parent = LootTable.create(title: "Parent Table", count: 1)
    child = LootTable.create(title: "Child Table", count: 1)
    item1 = LootItem.create(name: "Parent Item 1", probability: 1, loot_table_id: parent.id, inner_table_id: child.id)
    item2 = LootItem.create(name: "Child Item 1", probability: 1, loot_table_id: child.id)
    assert parent.roll().collect(&:name) == [item2.name]
  end

  test "loot items counts min == max" do
    table = LootTable.create(title: "My Table", count: 1)
    item1 = LootItem.create(name: "Item 1", probability: 1, loot_table_id: table.id, min: 5, max: 5)
    assert table.roll().first.count == 5
  end

  test "loot items with count ranges return a count within the range when rolled" do
    table = LootTable.create(title: "My Table", count: 1)
    item1 = LootItem.create(name: "Item 1", probability: 1, loot_table_id: table.id, min: 5, max: 10)
    100.times do
      count = table.roll().first.count
      assert count >= 5
      assert count <= 10
    end
  end

  test "results should be consolidated by item name" do
    table = LootTable.create(title: "My Table", count: 3)
    item1 = LootItem.create(name: "Alpha", probability: 1, loot_table_id: table.id, min: 5, max: 5, unique: true)
    item2 = LootItem.create(name: "Alpha", probability: 1, loot_table_id: table.id, min: 7, max: 7, unique: true)
    
    results = table.roll()
    assert results.length == 1
    assert results.first.name == "Alpha"
    assert results.first.count == 12
  end

  test "results should be consolidated by item name with inner table" do
    table = LootTable.create(title: "My Table", count: 3)
    item1 = LootItem.create(name: "Alpha", probability: 1, loot_table_id: table.id, min: 5, max: 5, unique: true)
    item2 = LootItem.create(name: "Alpha", probability: 1, loot_table_id: table.id, min: 7, max: 7, unique: true)
    table2 = LootTable.create(title: "Inner Table", count: 1)
    item3 = LootItem.create(name: "Alpha", probability: 1, loot_table_id: table.id, min: 10, max: 10, unique: true)

    results = table.roll()
    assert results.length == 1
    assert results.first.name == "Alpha"
    assert results.first.count == 22
  end
end
