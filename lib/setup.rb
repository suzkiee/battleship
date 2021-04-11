class Setup
  attr_reader :player_type,
              :board

  def initialize(ships, board, player_type)
    @board  = board
    @ships  = ships
    @player_type = player_type
  end

  def run_setup
    if @player_type == :computer
      place_all_computer_ships
    elsif @player_type == :user
      user_setup_intro(@ships, board)
      place_all_user_ships
    end
    @board
  end

  def user_setup_intro(ships, board)
    puts "\nOkay, I've placed my ships. I hope you're ready for this."
    puts "\nYou now need to place your own ships. Here's your fleet:"
    puts "\n"
    ships.each do |ship|
      puts "         #{ship.name}: #{ship.length} units long"
    end
    puts "\n"
    puts board.render
    return board.render
  end
  
  def user_place_ship(ship, board)
    puts "\nEnter the coordinates for #{ship.name} (#{ship.length} spaces, format: A1 B1 ):"
    print "> "
    user_input = gets.chomp.upcase
    puts "\n"
    coordinates = user_input.split(' ')
    while board.valid_placement?(ship, coordinates) == false
      puts "Nope! That's not a valid placement. Try again:"
      print "> "
      user_input = gets.chomp.upcase
      puts "\n"
      coordinates = user_input.split(' ')
    end
    board.place(ship, coordinates)
    puts board.render(true)
    puts "\n"
  end

  def place_computer_ship(ship, board)
    placement = random_coordinates(ship, board)
    while board.valid_placement?(ship, placement) == false
      placement = random_coordinates(ship, board)
    end
    board.place(ship, placement)
    placement
  end

  def place_all_computer_ships
    @ships.each do |ship|
      place_computer_ship(ship, @board)
    end
  end

  def place_all_user_ships
    @ships.each do |ship|
      user_place_ship(ship, @board)
    end
  end

  def random_coordinates(ship, board)
    length = ship.length
    coordinates = []
    while length > 0
      length -= 1
      coordinates << board.cells.keys.sample
    end
    coordinates
  end
end
