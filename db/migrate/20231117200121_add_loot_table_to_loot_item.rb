class AddLootTableToLootItem < ActiveRecord::Migration[7.1]
  def change
    add_column :loot_items, :inner_table_id, :integer
    add_foreign_key :loot_items, :loot_tables, column: :inner_table_id
  end
end
