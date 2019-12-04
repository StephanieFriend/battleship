class Cell
attr_reader :coordinate,
            :ship,
            :empty,
            :fired_upon
            :render

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = ship
    @empty = true
    @fired_upon = false
    @render = "."
  end

  def empty?
    empty
  end

  def place_ship(ship)
    @ship = ship
    @empty = false
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

    if @fired_upon == false
      "."
    elsif @empty == true
      "M"
    elsif @ship.hit
      "H"
    else
      "X"
    end

  end

end
