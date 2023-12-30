require "test_helper"

class RollsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @roll = rolls(:one)
  end

  test "should create roll" do
    assert_difference("Roll.count") do
      post loot_table_rolls_url(@roll.loot_table_id), params: { roll: { quantity: @roll.quantity } }
    end

    assert_redirected_to loot_table_url(@roll.loot_table_id)
  end
end
