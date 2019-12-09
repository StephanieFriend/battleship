class Game
  attr_reader :computer_board,
              :computer_cruiser,
              :computer_submarine,
              :player_board,
              :player_cruiser,
              :player_submarine

  def initialize
    @computer_board = nil
    @computer_cruiser = Ship.new("Cruiser", 3)
    @computer_submarine = Ship.new("Submarine", 2)
    @player_board = nil
    @player_cruiser = Ship.new("Cruiser", 3)
    @player_submarine = Ship.new("Submarine", 2)
  end
end
