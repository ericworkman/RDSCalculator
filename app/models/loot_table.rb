class LootTable < ApplicationRecord
  has_many :loot_items, dependent: :destroy

  validates :title, presence: true, uniqueness: true

  # Based very loosely on
  # https://www.codeproject.com/Articles/420046/Loot-Tables-Random-Maps-and-Monsters-Part-I
  def roll
    hit = 1 + rand(sum_probabilities)

    # This is a short cut compared to the source.
    # We can walk through the items, subtract the item probability from the hit count until its
    # less than or equal to an item's probability.
    found = nil
    loot_items.each do |item|
      if item.probability >= hit 
        found = item
        # No need to keep going
        break
      else
        hit -= item.probability
      end
    end
    found
  end

  def sum_probabilities
    loot_items.sum(&:probability)
  end
end
