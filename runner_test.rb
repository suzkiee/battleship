require 'rspec'
require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/setup'
require './lib/turn'

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

user_turn.display_boards

# turn.computer_shoots(user)
# turn.display_boards
# turn.user_shoots(computer)
# turn.display_boards
computer_turn.take_turn(computer, user, :computer)
user_turn.display_boards
user_turn.take_turn(computer, user, :human)
user_turn.display_boards