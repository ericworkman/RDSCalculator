require "test_helper"

class RollTest < ActiveSupport::TestCase
  test "should create loot after creation" do
    table = LootTable.create(title: "My Table")
    item1 = LootItem.create(name: "Alpha", probability: 1, loot_table_id: table.id, min: 5, max: 5, unique: true)

    roll = Roll.new(loot_table_id: table.id, quantity: 3)
    roll.save

    loot = Loot.where(roll_id: roll.id).all
    assert loot.length == 1
    assert loot.first.name = "Alpha"
    assert loot.first.quantity = 5
  end

  test "should consolidate loot by name" do
    table = LootTable.create(title: "My Table")
    item1 = LootItem.create(name: "Alpha", probability: 1, loot_table_id: table.id, min: 5, max: 5, unique: true)
    table2 = LootTable.create(title: "Inner Table")
    item2 = LootItem.create(name: "Alpha", probability: 1, loot_table_id: table2.id, min: 7, max: 7, unique: true)

    roll = Roll.new(loot_table_id: table.id, quantity: 3)
    roll.save

    loot = Loot.where(roll_id: roll.id).all
    assert loot.length == 1
    assert loot.first.name = "Alpha"
    assert loot.first.quantity = 12
  end
end
