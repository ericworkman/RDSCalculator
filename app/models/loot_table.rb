class LootTable < ApplicationRecord
  has_many :loot_items, dependent: :destroy

  validates :title, presence: true, uniqueness: true
end
