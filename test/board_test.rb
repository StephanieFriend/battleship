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

  def test_coordinates_are_consecutive_horzontally
    skip
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2", "A4"])
    assert_equal false, @board.valid_placement?(@cruiser, ["A3", "A2", "A1"])
    assert_equal true, @board.valid_placement?(@submarine, ["D2", "D3"])
  end
end
