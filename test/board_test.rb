require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'

class BoardTest < Minitest::Test

  def setup
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def test_it_exits
    assert_instance_of Board, @board
  end

  def test_board_has_cells

    assert_instance_of Hash, @board.cells
    assert_instance_of Cell, @board.cells["A1"]
    assert_equal 16, @board.cells.count
  end

  def test_that_board_can_validate_coordinates
    assert_equal true, @board.valid_coordinate?("A1")
    assert_equal false, @board.valid_coordinate?("A5")
    assert_equal true, @board.valid_coordinate?("D4")
    assert_equal false, @board.valid_coordinate?("E1")
    assert_equal false, @board.valid_coordinate?("A22")
  end

  def test_board_can_validate_length_of_ship_placement
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2"])
    assert_equal false, @board.valid_placement?(@submarine, ["A2", "A3", "A4"])
    assert_equal true, @board.valid_placement?(@cruiser, ["B1", "C1", "D1"])
    assert_equal true, @board.valid_placement?(@submarine, ["D2", "D3"])
  end

  def test_coordinates_are_consecutive_vertically
    assert_equal false, @board.vertical_placement?(["A1", "C1"])
    assert_equal true, @board.vertical_placement?(["A1", "B1", "C1"])
    assert_equal false, @board.vertical_placement?(["C1", "B1"])
  end

  def test_vertical_numbers_are_the_same
    assert_equal true, @board.vertical_numbers?(["A1", "B1", "C1"])
    assert_equal false, @board.vertical_numbers?(["A1", "B2", "C1"])
  end

  def test_vertical_letters_are_consecutive
    assert_equal true, @board.vertical_letters?(["A1", "B1", "C1"])
    assert_equal false, @board.vertical_letters?(["A1", "D1", "C1"])
  end

  def test_coordinates_are_consecutive_horizontally
    assert_equal false, @board.horizontal_placement?(["A1", "A2", "A4"])
    assert_equal false, @board.horizontal_placement?(["A3", "A2", "A1"])
    assert_equal true, @board.horizontal_placement?(["D2", "D3"])
  end

  def test_horizontal_letters_are_the_same
    assert_equal true, @board.horizontal_letters?(["A1", "A2", "A3"])
    assert_equal false, @board.horizontal_letters?(["A1", "B2", "A3"])
  end

  def test_horizontal_numbers_are_consecutive
    assert_equal true, @board.horizontal_numbers?(["A1", "A2", "A3"])
    assert_equal false, @board.horizontal_numbers?(["A1", "B4", "A3"])
  end

  def test_coordinates_cant_be_diagonal
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "B2", "C3"])
    assert_equal false, @board.valid_placement?(@submarine, ["C2", "D3"])
    assert_equal true, @board.valid_placement?(@submarine, ["A1", "A2"])
    assert_equal true, @board.valid_placement?(@cruiser, ["B1", "C1", "D1"])
  end

  def test_place_ships_horizontally
    @board.place(@cruiser, ["A1", "A2", "A3"])
    @board.place(@submarine, ["D1", "D2"])

    cell_1 = @board.cells["A1"]
    cell_2 = @board.cells["A2"]
    cell_3 = @board.cells["A3"]
    cell_4 = @board.cells["D1"]
    cell_5 = @board.cells["D2"]

    assert_equal @cruiser, cell_1.ship
    assert_equal @cruiser, cell_2.ship
    assert_equal @cruiser, cell_3.ship
    assert_equal @submarine, cell_4.ship
    assert_equal @submarine, cell_5.ship
    assert_equal true, cell_3.ship == cell_2.ship
    assert cell_4.ship == cell_5.ship
  end

  def test_place_ships_vertically
    @board.place(@cruiser, ["A1", "B1", "C1"])
    @board.place(@submarine, ["C3", "D3"])

    cell_1 = @board.cells["A1"]
    cell_2 = @board.cells["B1"]
    cell_3 = @board.cells["C1"]
    cell_4 = @board.cells["C3"]
    cell_5 = @board.cells["D3"]

    assert_equal @cruiser, cell_1.ship
    assert_equal @cruiser, cell_2.ship
    assert_equal @cruiser, cell_3.ship
    assert_equal @submarine, cell_4.ship
    assert_equal @submarine, cell_5.ship
  end
end
