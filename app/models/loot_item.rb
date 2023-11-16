class LootItem < ApplicationRecord
  belongs_to :loot_table

  validates :name, presence: true
  validates :probability, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
