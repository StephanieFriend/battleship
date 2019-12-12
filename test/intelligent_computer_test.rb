require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'
require './lib/intelligent_computer'

class IntelligentComputerTest < Minitest::Test

  def test_it_exits
    intelligent_computer = IntelligentComputer.new

    assert_instance_of IntelligentComputer, intelligent_computer
  end

  def test_it_initializes
    intelligent_computer = IntelligentComputer.new

    assert_instance_of Board, intelligent_computer.player_board
  end

  def test_it_can_stored_shot
    intelligent_computer = IntelligentComputer.new
    game = Game.new

    assert_equal [], intelligent_computer.stored_shot

    coordinate = game.computer_take_shot
    intelligent_computer.add_shot(coordinate)

    assert_equal [coordinate], intelligent_computer.stored_shot
  end

  def test_if_shot_was_hit_or_miss
    intelligent_computer = IntelligentComputer.new
    game = Game.new
    ship = Ship.new("Cruiser", 3)
    board = Board.new
    board.place(ship, ["A1", "A2", "A3"])

    coordinate = game.computer_take_shot
    intelligent_computer.add_shot(coordinate)
    # assert_equal true, coordinate.include?("A1", "A2", "A3")
  end
end
