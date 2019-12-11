class Cell
attr_reader :coordinate,
            :ship,
            :fired_upon

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    return false if place_ship(ship)
    true
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    fired_upon
  end

  def fire_upon
    @fired_upon = true
    if @ship
      @ship.hit
    end
  end

  def render(view = false)
    if @ship != nil && @ship.sunk? == true
      "X"
    elsif fired_upon? == true && empty? == false
      "H"
    elsif fired_upon? == true && empty? == true
      "M"
    elsif view == true && empty? == false
      "S"
    else
      "."
    end
  end
end
