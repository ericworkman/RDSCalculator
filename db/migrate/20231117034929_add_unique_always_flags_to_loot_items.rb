class AddUniqueAlwaysFlagsToLootItems < ActiveRecord::Migration[7.1]
  def change
    add_column :loot_items, :always, :boolean
    add_column :loot_items, :unique, :boolean
  end
end
