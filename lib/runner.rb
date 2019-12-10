require_relative '../lib/ship'
require_relative '../lib/cell'
require_relative '../lib/board'
require_relative '../lib/game'

game = Game.new
cruiser = Ship.new("Cruiser", 3)
submarine = Ship.new("Submarine", 2)

game.opening_message
game.computer_setup(cruiser)
game.computer_setup(submarine)
game.welcome
