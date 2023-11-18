require "test_helper"

class LootItemTest < ActiveSupport::TestCase
  test "count is consistent" do
    item1 = LootItem.create(name: "Item 1", probability: 1, min: 5, max: 10)
    first = item1.count
    10.times do
      assert first == item1.count
    end
  end
end
