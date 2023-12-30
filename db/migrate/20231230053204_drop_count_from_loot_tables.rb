class DropCountFromLootTables < ActiveRecord::Migration[7.1]
  def change
    remove_column :loot_tables, :count
  end
end
