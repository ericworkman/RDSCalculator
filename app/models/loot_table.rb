class LootTable < ApplicationRecord
  has_many :loot_items, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :count, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 100 }

  # Based loosely on
  # https://www.codeproject.com/Articles/420046/Loot-Tables-Random-Maps-and-Monsters-Part-I
  def roll
    # This is a short cut compared to the source.
    # We can walk through the items, subtract the item probability from the hit count until its
    # less than or equal to an item's probability.
    # It is also totally possible to make an impossible-to-match table, so we'll limit the number
    # of tries here for safety. This is probably good enough, except for higher counts and really
    # rare items. Common sense: don't force higher counts when items are really rare.
    found = always_items
    attempt = 0
    limit = 1000
    while (count > found.length) && (attempt < limit) do
      attempt += 1
      hit = 1 + rand(possible_probabilities)
      possible_items.each do |item|
        if item.probability >= hit
          # if the item is unique and found again, oh well
          if item.unique
            found << item unless found.include?(item)
          elsif item.inner_table
            found.push(*item.inner_table.roll())
          else
            found << item
          end
          # No need to keep going
          break
        else
          hit -= item.probability
        end
      end
    end
    # Compact the list by name to consolidate items
    consolidated = Hash.new
    found.each do |item|
      if consolidated.include? item.name
        consolidated[item.name].count += item.count
      else
        consolidated[item.name] = LootResult.new(item.name, item.count)
      end
    end
    consolidated.values
  end

  def possible_probabilities
    possible_items.sum(&:probability)
  end

  def possible_items
    loot_items.reject(&:always)
  end

  def always_items
    loot_items.filter(&:always)
  end
end
