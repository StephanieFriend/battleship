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
    puts "Welcome to BATTLESHIP \n" +
    "Enter p to play. Enter q to quit."
  end

  def welcome
    game_start = gets.chomp.downcase
      if game_start == "p"
        puts "Let's Play!"
        player_instructions
      elsif game_start ==  "q"
        puts "OK BYE"
      else
        puts "Invalid input, please choose p to play or q to quit"
        welcome
      end
  end

    def computer_setup(ship)
      coordinates = []
      loop do
        coordinates = @computer_board.cells.keys.sample(ship.length)
        # coordinates = cells.map do |cell|
        #   cell.coordinate
        # end
        break if  @computer_board.valid_placement?(ship, coordinates)
      end
      @computer_board.place(ship, coordinates)
    end

    def player_instructions
      puts "-------------------------------------------- \n" +
      "I have laid out my ships on the grid. \n" +
      "You now need to lay out your two ships. \n" +
      "The Cruiser is three units long and the Submarine is two units long."
      puts @player_board.render(true)
      player_place_cruiser
      player_place_submarine
    end

    def player_place_cruiser
      puts "Enter the squares for the Cruiser (3 spaces):"
        cruiser_response = gets.chomp.upcase.split

      if @player_board.valid_placement?(@player_cruiser, cruiser_response)
        @player_board.place(@player_cruiser, cruiser_response)
        puts @player_board.render(true)
      else
        puts "Those are invalid coordinates. Please try again:"
        player_place_cruiser
      end
    end

    def player_place_submarine
      puts "Enter the squares for the Submarine (2 spaces):"
        submarine_response = gets.chomp.upcase.split

      if @player_board.valid_placement?(@player_submarine, submarine_response)
        @player_board.place(@player_submarine, submarine_response)
      else
        puts "Those are invalid coordinates. Please try again:"
        player_place_submarine
      end
    end

    def start_game
      loop do
        render_boards
        break if game_over?
      end
    end

    def render_boards
      puts "=============COMPUTER BOARD============="
      puts @computer_board.render

      puts "==============PLAYER BOARD=============="
      puts @player_board.render(true)
    end

    def player_take_shot
      loop do
        puts "Enter the coordinate for your shot: "
        player_shot = gets.chomp.upcase
        break if @computer_board.valid_coordinate?(player_shot) && @computer_board.cells[player_shot].fired_upon?
        puts "Those are invalid coordinates. Please try again."
      end
      @computer_board.cells[player_shot].fire_upon
    end

    def game_over?
      true
    end

    def computer_take_shot
      
    end








end
