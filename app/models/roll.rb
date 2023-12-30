class Roll < ApplicationRecord
  belongs_to :loot_table
  has_many :loot, foreign_key: 'roll_id', class_name: 'Loot', dependent: :destroy

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 100 }

  after_save do |roll|
    loot_table.roll(number: quantity)
      .group_by{|li| li.name }
      .each do |name, lis|
        Loot.new(roll_id: roll.id, name: name, quantity: lis.sum(&:quantity)).save!
      end
  end
end
