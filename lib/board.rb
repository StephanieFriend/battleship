class Board
attr_reader :cells, :size, :owner, :x_label_max_len, :y_label_max_len

  def initialize(owner, size)
    @owner = owner.upcase
    @size = size
    @cells = {}
    currentY = "A"
    count = 1

    #For each letter, generate a row of cells
    while count <= size do
      for x in 1..size do
        coordString = currentY + x.to_s
        @cells[coordString] = Cell.new
      end

      # "Next" method gives you the logically next item based on a string (https://apidock.com/ruby/String/next)
      # This lets us handle the situation of "Z" -> "AA"
      currentY = currentY.next
      count += 1
    end

    #Save these for render down below
    @x_label_max_len = size.to_s.length
    @y_label_max_len = currentY.length
  end

  def valid_coordinate?(coordinate)
    @cells.keys.include?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    valid = coordinates.map do |coordinate|
      @cells.keys.include?(coordinate)
    end

    # This setup prevents a null object reference when trying to call "empty?" on a coordinate that doesn't exist
    if(valid.all?)
      empty = coordinates.map do |coordinate|
        @cells[coordinate].empty?
      end
      return ship_length?(ship, coordinates) && (coord_sequential?(coordinates, :y) ^ coord_sequential?(coordinates, :x)) && empty.all?
    end
    return false
  end

  ##
  # split coordinates into their X and Y parts, (x = numbers across the top, y = letters down the side)
  # Get the corresponding part to the axis we want to check
  # skip the first one (nil check)
  # if the current one is NOT incrementally 1 more than the previous, return false
  # if you've survived to the end, you're sequential, return true
  def coord_sequential?(coordinates, axis)
    privPartVal = nil
    coordinates.map do |coord|
      # split coordinates into their X and Y parts, (x = numbers across the top, y = letters down the side)
      y, x = coord.match(/([A-Z]*)(\d*)/).captures

      # Get the corresponding part to the axis we want to check
      if(axis == :x)
        partVal = x.to_i
      else
        partVal = y
      end

      # skip the first one (nil check)
      # if the current one is NOT incrementally 1 more than the previous, return false
      if(privPartVal != nil && privPartVal.next != partVal)
        return false
      end
      privPartVal = partVal
    end
    # if you've survived to the end, you're sequential, return true
    return true
  end

  def place(ship, coordinates)
    if valid_placement?(ship, coordinates)
      placement = coordinates.map do |coordinate|
        @cells[coordinate].place_ship(ship)
      end
    end
    placement
  end

  def ship_length?(ship, coordinates)
    ship.length == coordinates.length
  end

  # def vertical_placement?(coordinates)
  #   vertical_numbers?(coordinates) && vertical_letters?(coordinates)
  # end
  #
  # def horizontal_placement?(coordinates)
  #   horizontal_letters?(coordinates) && horizontal_numbers?(coordinates)
  # end
  #
  # def vertical_numbers?(coordinates)
  #   numbers = coordinates.map do |coordinate|
  #     coordinate.chars.last
  #   end
  #   numbers.uniq.length == 1
  # end
  #
  # def vertical_letters?(coordinates)
  #   new_range_array = []
  #   letters_range = ("A".."D").to_a
  #   letters = coordinates.map do |coordinate|
  #     coordinate.chars.first
  #   end
  #   letters_range.each_cons(coordinates.length) do |letter_range|
  #     new_range_array << letter_range
  #   end
  #   new_range_array.include?(letters)
  # end
  #
  # def horizontal_letters?(coordinates)
  #   letters = coordinates.map do |coordinate|
  #     coordinate.chars.first
  #   end
  #   letters.uniq.length == 1
  # end
  #
  # def horizontal_numbers?(coordinates)
  #   new_range_array = []
  #   numbers_range = ("1".."4").to_a
  #   numbers = coordinates.map do |coordinate|
  #     coordinate.chars.last
  #   end
  #   numbers_range.each_cons(coordinates.length) do |number_range|
  #     new_range_array << number_range
  #   end
  #   new_range_array.include?(numbers)
  # end

  def render(view = false)
    #Add padding for the Y coords to the header row
    # Start building the header line first so we know how wide to make the title line's padding
    header_line = " "
    count = 1
    while count <= @y_label_max_len do
      header_line << " "
      count += 1
    end

    #Print the number headers with padding so the dots all line up late
    for i in 1..@size do
      header_line << i.to_s.rjust(@x_label_max_len) + " "
    end

    header_line << "\n"

    # Assemble the title line
    title = "== " + @owner + " BOARD =="
    title_padding = ""
    count = 0
    while count < (header_line.length - title.length) / 2
      title_padding << "="
      count += 1
    end

    title_line = title_padding + title + title_padding + "\n"

    board_output = title_line
    board_output << header_line

    #Print each row, starting with the letter A and it's cell renders
    #Making sure to pad in case you have a row using 2 letters (ex. "AA" after row "Z")
    currentY = "A"
    count = 1
    while count <= size
      board_output << currentY.rjust(@y_label_max_len) + " "
      for i in 1..@size do
        board_output << @cells[currentY + i.to_s].render(view).rjust(@x_label_max_len) + " "
      end
      board_output << "\n"
      currentY = currentY.next
      count += 1
    end

    return board_output
  end

end
