require "test_helper"

class LootItemTest < ActiveSupport::TestCase
  test "should have a quantity in the range of min..max" do
    item1 = LootItem.create(name: "Item 1", probability: 1, min: 5, max: 10)
    100.times do
      quantity = item1.quantity
      assert quantity >= 5
      assert quantity <= 10
    end
  end

  test "should have a quantity of min when min == max" do
    item = LootItem.create(name: "Item 1", probability: 1, min: 5, max: 5)
    assert item.quantity == 5
  end
end
