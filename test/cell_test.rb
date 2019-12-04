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

  def test_ship_does_not_exist
    cell = Cell.new("B4")

    assert_nil cell.ship
  end

  def test_cell_defaults_as_empty
    cell = Cell.new("B4")

    assert_equal true, cell.empty?
  end

  def test_place_ship_on_cell
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    cell.place_ship(cruiser)

    assert_equal cruiser, cell.ship
    refute cell.empty?
  end

  def test_fired_upon_starts_as_false
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    cell.place_ship(cruiser)
    refute cell.fired_upon?
  end

  def test_fire_upon_method_decreases_health
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    cell.place_ship(cruiser)
    cell.fire_upon

    assert_equal 2, cell.ship.health
    assert cell.fired_upon?
  end

  def test_default_rendering_of_cell_returns_dot
    cell_1 = Cell.new("B4")

    assert_equal ".", cell_1.render
  end

  def test_if_fired_upon_returns_m_if_missed
    cell_1 = Cell.new("B4")
    cell_1.fire_upon

    assert_equal "M", cell_1.render
  end

  def test_when_render_true_reveal_ships
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)

    cell_2.place_ship(cruiser)

    assert_equal ".", cell_2.render
    assert_equal "S", cell_2.render(true)
  end

  def test_when_render_true_on_empty_cell
    cell_2 = Cell.new("C3")

    assert_equal ".", cell_2.render
    assert_equal ".", cell_2.render(true)
  end
end
