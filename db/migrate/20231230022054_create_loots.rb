class CreateLoots < ActiveRecord::Migration[7.1]
  def change
    create_table :loots do |t|
      t.integer :quantity
      t.string :name
      t.references :roll, null: false, foreign_key: true

      t.timestamps
    end
  end
end
