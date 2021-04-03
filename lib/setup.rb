class Setup
  attr_reader :player,
              :board

  def initialize(board, ships, player)
    @board  = board
    @ships  = ships
    @player = player
  end

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
end

## need to instantialize this twice in the Game class
## need instance variable that tells us which kind of player
## then need to do the full setup for the computer
## but ask human user for inputs for their own board
