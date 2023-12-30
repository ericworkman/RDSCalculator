require "test_helper"

class LootTableTest < ActiveSupport::TestCase
  test "#roll should return an array of loot_items" do
    table = LootTable.create(title: "My Table")
    item1 = LootItem.create(name: "Item 1", probability: 0, loot_table_id: table.id)
    item2 = LootItem.create(name: "Item 2", probability: 1, loot_table_id: table.id)
    roll = table.roll()
    assert roll.first.name == item2.name
  end

  test "#roll should select a loot_item that is marked always" do
    table = LootTable.create(title: "My Table")
    item1 = LootItem.create(name: "Item 1", probability: 1, loot_table_id: table.id, always: true)
    item2 = LootItem.create(name: "Item 2", probability: 100, loot_table_id: table.id)
    300.times do
      assert table.roll().first.name == item1.name
    end
  end

  test "#roll should not select a unique item more than once" do
    table = LootTable.create(title: "My Table")
    item1 = LootItem.create(name: "Item 1", probability: 1, loot_table_id: table.id)
    item2 = LootItem.create(name: "Item 2", probability: 1000, loot_table_id: table.id, unique: true)
    300.times do
      refute table.roll(number: 2).collect(&:name) == [item2.name, item2.name]
    end
  end

  test "#roll rolls a loot_item's inner table" do
    parent = LootTable.create(title: "Parent Table")
    child = LootTable.create(title: "Child Table")
    item1 = LootItem.create(name: "Parent Item 1", probability: 1, loot_table_id: parent.id, inner_table_id: child.id)
    item2 = LootItem.create(name: "Child Item 1", probability: 1, loot_table_id: child.id)
    assert parent.roll().collect(&:name) == [item2.name]
  end
end
