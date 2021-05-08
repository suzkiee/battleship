class Setup
  attr_reader :player_type,
              :board,
              :ships

  def initialize( player_type,
                  config_options = {board: Board.new,
                                    ships: Shipyard.create_ships,
                                    messages: Messages.new,
                                    user_input: UserInput.new})
    @player_type = player_type
    @board  = config_options[:board]
    @ships  = config_options[:ships]
    @messages = config_options[:messages]
    @user_input = config_options[:user_input]
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
    puts @messages.user_setup_intro
    list_ships(ships)
    puts @messages.new_line
    puts board.render
    return board.render
  end

  def user_place_ship(ship, board)
    puts @messages.request_coordinates(ship)
    coordinates = get_valid_placement(ship)
    board.place(ship, coordinates)
    puts board.render(true)
    puts @messages.new_line
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

  private

    def list_ships(ships)
      ships.each do |ship|
      puts @messages.ship_details(ship)
      end
    end

    def get_valid_placement(ship)
      coordinates = get_multiple_coordinates
      while board.valid_placement?(ship, coordinates) == false
        puts @messages.invalid_placement
        coordinates = get_multiple_coordinates
      end
      coordinates
    end

    def get_multiple_coordinates
      user_input = @user_input.get_input
      puts "> #{user_input} \n"
      user_input.split(' ')
    end
end
