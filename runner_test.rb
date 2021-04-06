require 'rspec'
require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/setup'
require './lib/turn'
require './lib/game'

computer_board = Board.new
user_board = Board.new
submarine = Ship.new("Submarine", 2)
cruiser = Ship.new("Cruiser", 3)

ships = [submarine, cruiser]
computer_setup = Setup.new(computer_board, ships, :computer)
computer = computer_setup.run_setup

user_setup = Setup.new(user_board, ships, :human)
user = user_setup.run_setup

computer_turn = Turn.new(computer, user, :computer)
user_turn = Turn.new(computer, user, :human)
game = Game.new

# turn.computer_shoots(user)
# turn.display_boards
# turn.user_shoots(computer)
# turn.display_boards
game.take_turns(user, computer)
