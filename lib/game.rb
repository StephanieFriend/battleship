class Game
  attr_reader :computer_board,
              :player_board,
              :ai

  @player_ships
  @computer_ships

  def initialize_new_game(board_size)
    @computer_board = Board.new("computer", board_size)
    # @computer_cruiser = Ship.new("Cruiser", 3)
    # @computer_submarine = Ship.new("Submarine", 2)
    @player_board = Board.new("player", board_size)
    # @player_cruiser = Ship.new("Cruiser", 3)
    # @player_submarine = Ship.new("Submarine", 2)
    @player_ships = []
    @computer_ships = []
    @ai = Ai.new(@player_board)
  end

  def start_game
    puts "Welcome to BATTLESHIP \n" +
    "Enter p to play. Enter q to quit."

    game_start = gets.chomp.downcase
      if game_start == "p"
        puts "Let's Play!"
        initialize_new_game(prompt_board_size)
        # computer_setup(@computer_cruiser)
        # computer_setup(@computer_submarine)
        player_instructions
        computer_setup(@computer_ships)
        run_game
      elsif game_start ==  "q"
        puts "OK BYE"
      else
        puts "Invalid input, please choose p to play or q to quit"
        welcome
      end
  end

  def prompt_board_size
    puts "How big of a board should we play on?"
    user_num = -1
    loop do
      user_num=Integer(gets.chomp.upcase) rescue false
      break if user_num != false && user_num >= 4
      if(user_num != false && user_num < 0)
        puts "Ok, wtf are you doing, seriously?"
      elsif (user_num != false && user_num < 4)
        puts "Come on, don't be a pussy."
      elsif(user_num == false)
        puts "That's not a number idiot."
      end
    end
    return user_num
  end

  def new_sub
    return Ship.new("Submarine",2)
  end

  def new_cruiser
    return Ship.new("Cruiser",3)
  end

  def new_battleship
    return Ship.new("Battleship", 4)
  end

  def new_flagship
    return Ship.new("Flagship", 5)
  end
  ##
  # Process:
  # Pick an axis
  # Pick a starting coordinate
  # get the ship length minus 1 more coordinates since we started with the first one (so we have coordinate count = to ship length)
  # check placemen
  def computer_setup(ships)
    ships.map do |ship|
      coordinates = []
      loop do
        axis = rand(1..2) == 1 ? :x : :y
        current_coord = @computer_board.cells.keys.sample
        coordinates = [current_coord]
        (ship.length - 1).times do
            current_coord = get_next_coord_for_axis(current_coord, axis)
            coordinates << current_coord
        end
        break if  @computer_board.valid_placement?(ship, coordinates)
        coordinates = []
      end
      @computer_board.place(ship, coordinates)
    end
    puts "Ok! My ships are placed."
  end

  def get_next_coord_for_axis(coord, axis)
    y, x = coord.match(/([A-Z]*)(\d*)/).captures
    if(axis == :x)
      return y + x.next
    else
      return y.next + x
    end
  end

  def player_instructions
    puts "-------------------------------------------- \n" +
    "You now need to lay out your ships. \n"
    place_ship_menu
    puts @player_board.render(true)
  end

  def place_ship_menu
    loop do
      puts "Pick a ship type:\n" +
      "1 -> Submarine (size 2)\n" +
      "2 -> Cruiser (size 3)\n" +
      "3 -> Battleship (size 4)\n" +
      "4 -> Flagship (size 5)\n" +
      "q -> Done placing ships\n"
      rawinput = gets.chomp.downcase
      if(rawinput == "q" && @player_ships.length >= 1)
        break
      elsif (rawinput == "q" && @player_ships.length < 1)
        puts "You have to have atleast 1 ship."
        next
      end

      cleanInput = Integer(rawinput) rescue false
      if(cleanInput == false || cleanInput === (1..4))
        puts "Invalid ship selection."
        next
      end

      case cleanInput
      when 1
        ship = new_sub
        player_place_ship(ship)
        @player_ships << ship
        @computer_ships << new_sub
      when 2
        ship = new_cruiser
        player_place_ship(ship)
        @player_ships << ship
        @computer_ships << new_cruiser
      when 3
        ship = new_battleship
        player_place_ship(ship)
        @player_ships << ship
        @computer_ships << new_battleship
      when 4
        if(@player_board.size < 5)
          puts "This ship won't fit on the board"
          next
        end
        ship = new_flagship
        player_place_ship(ship)
        @player_ships << ship
        @computer_ships << new_flagship
      end
    end
  end

  def player_place_ship(ship)
    puts @player_board.render(true)
    loop do
      puts "Enter the squares for the #{ship.name} (#{ship.length} spaces): "
        intput = gets.chomp.upcase.split

      if @player_board.valid_placement?(ship, intput)
        @player_board.place(ship, intput)
        puts @player_board.render(true)
        break
      else
        puts "Those are invalid coordinates. Please try again:"
      end
    end
  end

  # def player_place_cruiser
  #   puts "Enter the squares for the Cruiser (3 spaces):"
  #     cruiser_response = gets.chomp.upcase.split
  #
  #   if @player_board.valid_placement?(@player_cruiser, cruiser_response)
  #     @player_board.place(@player_cruiser, cruiser_response)
  #     puts @player_board.render(true)
  #   else
  #     puts "Those are invalid coordinates. Please try again:"
  #     player_place_cruiser
  #   end
  # end
  #
  # def player_place_submarine
  #   puts "Enter the squares for the Submarine (2 spaces):"
  #     submarine_response = gets.chomp.upcase.split
  #
  #   if @player_board.valid_placement?(@player_submarine, submarine_response)
  #     @player_board.place(@player_submarine, submarine_response)
  #   else
  #     puts "Those are invalid coordinates. Please try again:"
  #     player_place_submarine
  #   end
  # end

  def run_game
    loop do
      render_boards
      player_take_shot
      if game_over?(@computer_ships)
        render_boards
        puts "You won!"
        break
      end
      computer_take_shot
      if game_over?(@player_ships)
        render_boards
        puts "I won!"
        break
      end
    end
    start_game
  end

  def game_over?(ships)
    ships.map do |ship|
      if(!ship.sunk?)
        return false
      end
    end
    return true
  end

  def render_boards
    puts @computer_board.render
    puts @player_board.render(true)
  end

  def player_take_shot
    player_shot = nil
    loop do
      puts "Enter the coordinate for your shot: "
      input = gets.chomp.upcase

      # Cheat Codes!!
      if(input == "DEBUG_KILL_COMP")
        puts "Cheater! You sunk the computer's ships!"
        kill_all(@computer_ships)
        return
      end

      if(input == "DEBUG_KILL_ME")
        puts "Cheater! You sunk your ships!"
        kill_all(@player_ships)
        return
      end

      # If the passes in R, pick a random valid available cell and shoot at it
      if(input != "R")
        player_shot = input
      else
        loop do
          player_shot = @computer_board.cells.keys.sample
          break if @computer_board.valid_coordinate?(player_shot) && !@computer_board.cells[player_shot].fired_upon?
        end
      end

      break if @computer_board.valid_coordinate?(player_shot) && !@computer_board.cells[player_shot].fired_upon?
      puts "Those are invalid coordinates. Please try again."
    end
    shot_result = @computer_board.cells[player_shot].fire_upon
    puts shot_message(player_shot, shot_result, "Your")
  end

  def kill_all(ships)
    ships.map do |ship|
      ship.sink
    end
  end

  # def game_over?(cruiser, submarine)
  #   cruiser.sunk? && submarine.sunk?
  # end

  # def computer_take_shot
  #   coordinate = nil
  #   loop do
  #     coordinate = @player_board.cells.keys.sample
  #     break if !@player_board.cells[coordinate].fired_upon?
  #   end
  #   shot_result = @player_board.cells[coordinate].fire_upon
  #   puts shot_message(coordinate, shot_result, "My")
  # end

  def computer_take_shot
    target_coord = @ai.next_shot
    shot_result = @player_board.cells[target_coord].fire_upon
    @ai.compute_next_shot(target_coord, shot_result)
    puts shot_message(target_coord, shot_result, "My")
  end

  def shot_message(coordinate, result, shooter)
    if result == true
      result_message = "hit"
    else
      result_message = "miss"
    end
    "#{shooter} shot on #{coordinate} was a #{result_message}."
  end

end
