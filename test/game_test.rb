require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'


class GameTest < Minitest::Test

  def setup
    @game = Game.new
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_it_initializes
    assert_instance_of Board, @game.computer_board
    assert_instance_of Ship, @game.computer_cruiser
    assert_equal "Cruiser", @game.computer_cruiser.name
    assert_instance_of Ship, @game.computer_submarine
    assert_equal 2, @game.computer_submarine.length
    assert_instance_of Board, @game.player_board
    assert_instance_of Ship, @game.player_cruiser
    assert_instance_of Ship, @game.player_submarine
  end

  def test_generate_cells_in_computer_setup
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_instance_of Array, @game.computer_setup(cruiser)
    assert_instance_of Array, @game.computer_setup(submarine)
    assert_equal 3, @game.computer_setup(cruiser).count
    assert_equal 2, @game.computer_setup(submarine).count
    # assert_equal coordinates.first.empty?, @game.computer_setup(cruiser)
  end
end
