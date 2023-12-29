require "test_helper"

class LootTablesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @loot_table = loot_tables(:one)
  end

  test "should get index" do
    get loot_tables_url
    assert_response :success
  end

  test "should get new" do
    get new_loot_table_url
    assert_response :success
  end

  test "should create loot_table" do
    assert_difference("LootTable.count") do
      post loot_tables_url, params: { loot_table: { title: "New Title", count: 10 } }
    end

    assert_redirected_to loot_table_url(LootTable.last)
  end

  test "should show loot_table" do
    get loot_table_url(@loot_table)
    assert_response :success
  end

  test "should get edit" do
    get edit_loot_table_url(@loot_table)
    assert_response :success
  end

  test "should update loot_table" do
    patch loot_table_url(@loot_table), params: { loot_table: { title: "New Title" } }
    assert_redirected_to loot_table_url(@loot_table)
  end

  test "should destroy loot_table" do
    assert_difference("LootTable.count", -1) do
      delete loot_table_url(@loot_table)
    end

    assert_redirected_to loot_tables_url
  end

  test "should select the loot item on roll" do
    expected_item = loot_items(:one)
    post roll_loot_table_url(@loot_table), xhr: true
    assert_response :success
    assert_match expected_item.name, @response.body
  end
end
