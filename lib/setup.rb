class Setup
  attr_reader :player,
              :board

  def initialize(board, ships, player)
    @board  = board
    @ships  = ships
    @player = player
  end

  # run class - set up for player

  def place_computer_ship(ship, board)
    placement = random_coordinates(ship, board)
    while board.valid_placement?(ship, placement) == false
      placement = random_coordinates(ship, board)
    end 
    board.place(ship, placement)
    placement
  end

  def random_coordinates(ship, board)
    length = ship.length
    coordinates = []

    while length > 0
      length -= 1
      coordinates << board.cells.keys.sample
    end
    return coordinates
  end

  # player ship placement 
  # intro - text and render empty board 
  # place_player ship 

  def run_setup
    puts "Hi"
  end

  def player_setup_intro(board, ships)
    puts "Okay, I've placed my ships. I hope you're ready for this."
    puts "You now need to place your own ships. Here's you armada:"
    ships.each do |ship|
      puts "#{ship.name}: #{ship.length} units long"
    end
    puts board.render
    return board.render
  end
  
  def player_place_ship(board, ship)
    puts "Enter the coordinates for #{ship.name} (#{ship.length} spaces, format: A1 B1 ):"
    user_input = gets.chomp
    coordinates = user_input.split(' ')
    while board.valid_placement?(ship, coordinates) == false
      puts "Nope! That's not a valid placement. Try again:"
      user_input = gets.chomp
      coordinates = user_input.split(' ')
    end
    board.place(ship, coordinates)
    puts board.render(true)
  end
end

# need to instantialize this twice in the Game class
# need instance variable that tells us which kind of player
# then need to do the full setup for the computer
# but ask human user for inputs for their own board
