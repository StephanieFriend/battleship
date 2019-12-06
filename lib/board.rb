class Board
attr_reader :cells

  def initialize
    @cells = {"A1" => Cell.new("A1"),
              "A2" => Cell.new("A2"),
              "A3" => Cell.new("A3"),
              "A4" => Cell.new("A4"),
              "B1" => Cell.new("B1"),
              "B2" => Cell.new("B2"),
              "B3" => Cell.new("B3"),
              "B4" => Cell.new("B4"),
              "C1" => Cell.new("C1"),
              "C2" => Cell.new("C2"),
              "C3" => Cell.new("C3"),
              "C4" => Cell.new("C4"),
              "D1" => Cell.new("D1"),
              "D2" => Cell.new("D2"),
              "D3" => Cell.new("D3"),
              "D4" => Cell.new("D4")
    }
  end

  def valid_coordinate?(coordinate)
    @cells.include?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    ship.length == coordinates.length && (vertical_placement?(coordinates) || horizontal_placement?(coordinates))
  end

  def vertical_placement?(coordinates)
    vertical_numbers?(coordinates) && vertical_letters?(coordinates)
  end

  def horizontal_placement?(coordinates)
    horizontal_letters?(coordinates) && horizontal_numbers?(coordinates)
  end

  def vertical_numbers?(coordinates)
    numbers = coordinates.map do |coordinate|
      coordinate.chars.last
    end
    numbers.uniq.length == 1
  end

  def vertical_letters?(coordinates)
    new_range_array = []
    letters_range = ("A".."D").to_a
    letters = coordinates.map do |coordinate|
      coordinate.chars.first
    end
    letters_range.each_cons(coordinates.length) do |letter_range|
      new_range_array << letter_range
    end
    new_range_array.include?(letters)
  end

  def horizontal_letters?(coordinates)
    letters = coordinates.map do |coordinate|
      coordinate.chars.first
    end
    letters.uniq.length == 1
  end

  def horizontal_numbers?(coordinates)
    new_range_array = []
    numbers_range = ("1".."4").to_a
    numbers = coordinates.map do |coordinate|
      coordinate.chars.last
    end
    numbers_range.each_cons(coordinates.length) do |number_range|
      new_range_array << number_range
    end
    new_range_array.include?(numbers)
  end

end
