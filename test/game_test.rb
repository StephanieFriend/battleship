require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'


class GameTest < Minitest::Test

  def setup
    @game = Game.new
    @game.initialize_new_game
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_it_initializes_new_game
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
  end

  def test_computer_take_shot
    @game.computer_take_shot

    shot_count = 0

    @game.player_board.cells.map do |key, cell|
      if cell.fired_upon?
        shot_count += 1
      end
    end

    assert_equal 1, shot_count

    @game.computer_take_shot

    shot_count = 0

    @game.player_board.cells.map do |key, cell|
      if cell.fired_upon?
        shot_count += 1
      end
    end

    assert_equal 2, shot_count
  end

  def test_game_over
    cruiser = Ship.new("Cruiser", 1)
    submarine = Ship.new("Submarine", 1)

    assert_equal false, @game.game_over?(cruiser,submarine)

    cruiser.hit
    submarine.hit

    assert_equal true, @game.game_over?(cruiser, submarine)
  end

  def test_for_hit_shot
    assert_equal "Your shot on A1 was a hit.", @game.shot_message("A1", true, "Your")
  end

  def test_for_miss_shot
    assert_equal "Your shot on A1 was a miss.", @game.shot_message("A1", false, "Your")
  end
end
