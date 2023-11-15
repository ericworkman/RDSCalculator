require "application_system_test_case"

class LootTablesTest < ApplicationSystemTestCase
  setup do
    @loot_table = loot_tables(:one)
  end

  test "visiting the index" do
    visit loot_tables_url
    assert_selector "h1", text: "Loot tables"
  end

  test "should create loot table" do
    visit loot_tables_url
    click_on "New loot table"

    fill_in "Title", with: @loot_table.title
    click_on "Create Loot table"

    assert_text "Loot table was successfully created"
    click_on "Back"
  end

  test "should update Loot table" do
    visit loot_table_url(@loot_table)
    click_on "Edit this loot table", match: :first

    fill_in "Title", with: @loot_table.title
    click_on "Update Loot table"

    assert_text "Loot table was successfully updated"
    click_on "Back"
  end

  test "should destroy Loot table" do
    visit loot_table_url(@loot_table)
    click_on "Destroy this loot table", match: :first

    assert_text "Loot table was successfully destroyed"
  end
end
