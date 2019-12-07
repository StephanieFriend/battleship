class Cell
attr_reader :coordinate,
            :ship,
            :fired_upon

            # :render

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil 
    @fired_upon = false
    # @render = "."
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
    if view == true && empty? == false
      "S"
    elsif @fired_upon == false
      "."
    elsif empty? == true
      "M"
    elsif @ship.sunk? == true
      "X"
    else
      "H"
    end
  end
end
