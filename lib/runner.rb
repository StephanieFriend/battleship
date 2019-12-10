require_relative '../lib/ship'
require_relative '../lib/cell'
require_relative '../lib/board'
require_relative '../lib/game'

game = Game.new

puts game.opening_message

puts game.welcome

puts game.player_instructions

puts game.player_setup
