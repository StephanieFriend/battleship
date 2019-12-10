class Game
  attr_reader :computer_board,
              :computer_cruiser,
              :computer_submarine,
              :player_board,
              :player_cruiser,
              :player_submarine

  def initialize
    @computer_board = Board.new
    @computer_cruiser = Ship.new("Cruiser", 3)
    @computer_submarine = Ship.new("Submarine", 2)
    @player_board = Board.new
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

    def computer_setup(ship)
      coordinates = []
      loop do
        cells = @computer_board.cells.values.sample(ship.length)
        coordinates = cells.map do |cell|
          cell.coordinate
        end
        break if  @computer_board.valid_placement?(ship, coordinates)
      end
      @computer_board.place(ship, coordinates)
    end

    def player_instructions
      "-------------------------------------------- \n" +
      "I have laid out my ships on the grid. \n" +
      "You now need to lay out your two ships. \n" +
      "The Cruiser is three units long and the Submarine is two units long."


      "Enter the squares for the Cruiser (3 spaces):"
      cruiser_response = gets.chomp
    end

    def player_setup
      @player_board.render(true)
    end


end
