require "application_system_test_case"

class LootItemsTest < ApplicationSystemTestCase
  setup do
    @loot_item = loot_items(:one)
  end

  test "visiting the index" do
    visit loot_items_url
    assert_selector "h1", text: "Loot items"
  end

  test "should create loot item" do
    visit loot_items_url
    click_on "New loot item"

    fill_in "Loot table", with: @loot_item.loot_table_id
    fill_in "Name", with: @loot_item.name
    fill_in "Probability", with: @loot_item.probability
    click_on "Create Loot item"

    assert_text "Loot item was successfully created"
    click_on "Back"
  end

  test "should update Loot item" do
    visit loot_item_url(@loot_item)
    click_on "Edit this loot item", match: :first

    fill_in "Loot table", with: @loot_item.loot_table_id
    fill_in "Name", with: @loot_item.name
    fill_in "Probability", with: @loot_item.probability
    click_on "Update Loot item"

    assert_text "Loot item was successfully updated"
    click_on "Back"
  end

  test "should destroy Loot item" do
    visit loot_item_url(@loot_item)
    click_on "Destroy this loot item", match: :first

    assert_text "Loot item was successfully destroyed"
  end
end
