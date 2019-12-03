require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

class CellTest < Minitest::Test

  def test_it_exits
    cell = Cell.new("B4")

    assert_instance_of Cell, cell
  end

  def test_cell_has_coordinate
    cell = Cell.new("B4")

    assert_equal "B4", cell.coordinate
  end
end
