class LootTable < ApplicationRecord
  has_many :loot_items, dependent: :destroy
  has_many :rolls, dependent: :destroy

  validates :title, presence: true, uniqueness: true

  # Based loosely on
  # https://www.codeproject.com/Articles/420046/Loot-Tables-Random-Maps-and-Monsters-Part-I
  # 
  # Walk through the items, subtract the item probability from the hit count until its less than
  # or equal to an item's probability. It is also possible to make an impossible-to-match table or
  # to ask for many very rare items, so we'll limit the number of attempts here for safety.
  # 
  # @param number [Integer] the number of results to get before stopping
  # @param attempt [Integer] the current attempt at getting results
  # @param limit [Integer] how many times to try to get results
  # @return [Array] of chosen loot_items
  def roll(number: 1, attempt: 0, limit: 1000)
    found = always_items
    
    while (number > found.length) && (attempt < limit) do
      attempt += 1
      hit = rand_hit()

      possible_items.each do |item|
        if item.probability >= hit
          if item.unique
            # if the item is unique and found again, oh well
            found << item unless found.include?(item)
          elsif item.inner_table
            found.push(*item.inner_table.roll(number: number - found.length, attempt: attempt, limit: limit))
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

    found
  end

  private

  def possible_items
    loot_items.reject(&:always)
  end

  def always_items
    loot_items.filter(&:always)
  end

  def possible_probabilities
    possible_items.sum(&:probability)
  end

  def rand_hit
    1 + rand(possible_probabilities)
  end
end
