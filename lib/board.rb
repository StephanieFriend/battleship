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
    ship.length == coordinates.length
    # && coordinates.empty?
  end

  def vertical_placement?(coordinates)
    #array of letter order
    #bring numbers and letters method together to
    #test if they are valid
    #maybe see if we can test if they are also
    #inside the array of letters with only letters method
    vertical_numbers?(coordinates) && vertical_letters?(coordinates)
  end

  def vertical_numbers?(coordinates)
    #verifying that all the numbers are the same
    numbers = coordinates.map do |coordinate|
      coordinate.chars.last
    end
    numbers.uniq.length == 1
  end

  def vertical_letters?(coordinates)
    #verifying that the letters are consecutive
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

end
