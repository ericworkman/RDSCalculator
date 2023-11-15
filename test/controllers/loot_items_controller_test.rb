require "test_helper"

class LootItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @loot_table = loot_tables(:one)
    @loot_item = loot_items(:one)
  end

  test "should get new" do
    get new_loot_table_loot_item_url(@loot_table)
    assert_response :success
  end

  test "should create loot_item" do
    assert_difference("LootItem.count") do
      post loot_table_loot_items_url(@loot_table), params: { loot_item: { name: "New Loot Item", probability: 1 } }
    end

    assert_redirected_to loot_table_url(@loot_table)
  end

  test "should show loot_item" do
    get loot_table_loot_item_url(@loot_table, @loot_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_loot_table_loot_item_url(@loot_table, @loot_item)
    assert_response :success
  end

  test "should update loot_item" do
    patch loot_table_loot_item_url(@loot_table, @loot_item), params: { loot_item: { name: @loot_item.name, probability: @loot_item.probability } }
    assert_redirected_to loot_table_url(@loot_table)
  end

  test "should destroy loot_item" do
    assert_difference("LootItem.count", -1) do
      delete loot_table_loot_item_url(@loot_table, @loot_item)
    end

    assert_redirected_to loot_table_url(@loot_table)
  end
end
