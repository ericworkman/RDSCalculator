class CreateRolls < ActiveRecord::Migration[7.1]
  def change
    create_table :rolls do |t|
      t.integer :quantity
      t.references :loot_table, null: false, foreign_key: true

      t.timestamps
    end
  end
end
