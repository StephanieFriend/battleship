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

  def opening_message
    "Welcome to BATTLESHIP \n" +
    "Enter p to play. Enter q to quit."
  end
  def welcome
    game_start = gets.chomp.downcase
      if game_start == "p"
        "Let's Play!"
        #starting game
      elsif game_start ==  "q"
        "OK BYE"
      else
        puts "Invalid input, please choose p to play or q to quit"
        welcome
      end
  end
end
