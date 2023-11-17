class LootItem < ApplicationRecord
  belongs_to :loot_table
  belongs_to :inner_table, optional: true, class_name: "LootTable"

  validates :name, presence: true
  validates :probability, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
