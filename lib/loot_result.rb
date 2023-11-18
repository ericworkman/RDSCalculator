class LootResult
  attr_accessor :name, :count

  def initialize(name, count)
    @name = name
    @count = count
  end
end