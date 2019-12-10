require_relative '../lib/ship'
require_relative '../lib/cell'
require_relative '../lib/board'
require_relative '../lib/game'

game = Game.new

game.opening_message
game.welcome
game.player_place_cruiser
