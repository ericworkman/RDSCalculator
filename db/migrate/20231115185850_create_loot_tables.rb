class CreateLootTables < ActiveRecord::Migration[7.1]
  def change
    create_table :loot_tables do |t|
      t.string :title

      t.timestamps
    end
  end
end
