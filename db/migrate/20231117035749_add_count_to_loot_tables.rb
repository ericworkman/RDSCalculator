class AddCountToLootTables < ActiveRecord::Migration[7.1]
  def change
    add_column :loot_tables, :count, :integer, default: 1
  end
end
