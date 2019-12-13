class Ship

  attr_reader :name, :length, :health

  def initialize(name, length)
    @name = name
    @length = length
    @health = length
    @sunk = false
  end

  def sunk?
    if @health <= 0 # Changed to less than or equal to handle -1 HP caused by cheat code use
      @sunk = true
      return true
    else
      @sunk = false
      return false
    end
  end

  def sink
    @health = 0
  end

  def hit
    @health -= 1
  end
end
