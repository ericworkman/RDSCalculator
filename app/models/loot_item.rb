class LootItem < ApplicationRecord
  belongs_to :loot_table
  belongs_to :inner_table, optional: true, class_name: "LootTable"

  validates :name, presence: true
  validates :probability, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :min, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :max, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: :min }

  def count
    @count ||= begin
      return min if min == max
      min + rand(1 + max - min)
    end
  end
end
