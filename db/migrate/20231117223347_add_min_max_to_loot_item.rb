class AddMinMaxToLootItem < ActiveRecord::Migration[7.1]
  def change
    add_column :loot_items, :min, :integer, default: 1
    add_column :loot_items, :max, :integer, default: 1
  end
end
