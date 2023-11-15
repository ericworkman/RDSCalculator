class CreateLootItems < ActiveRecord::Migration[7.1]
  def change
    create_table :loot_items do |t|
      t.string :name
      t.integer :probability
      t.references :loot_table, null: false, foreign_key: true

      t.timestamps
    end
  end
end
