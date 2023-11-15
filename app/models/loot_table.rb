class LootTable < ApplicationRecord
  has_many :loot_items, dependent: :destroy

  validates :title, presence: true, uniqueness: true

  def roll
    total_probability = loot_items.sum(&:probability)
    hit = 1 + rand(total_probability)
    found = nil
    loot_items.each do |item|
      if item.probability >= hit 
        found = item
        break
      else
        hit -= item.probability
      end
    end
    found
  end
end
