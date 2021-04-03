class Setup
  def initialize(board, ships)
    @board = board
    @ships = ships
  end
end

## need to instantialize this twice in the Game class
## need instance variable that tells us which kind of player
## then need to do the full setup for the computer
## but ask human user for inputs for their own board
