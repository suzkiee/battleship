require 'rspec'
require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/setup'
require './lib/turn'

describe Turn do
  it 'exists' do
    board = Board.new
    submarine = Ship.new("Submarine", 2)
    cruiser = Ship.new("Cruiser", 3)
    ships = [submarine, cruiser]
    setup = Setup.new(board, ships, :computer)
    turn = Turn.new(board)

    expect(turn).is_a? Turn
  end

  it 'has a board' do
    board = Board.new
    submarine = Ship.new("Submarine", 2)
    cruiser = Ship.new("Cruiser", 3)
    ships = [submarine, cruiser]
    computer_board = Setup.new(board, ships, :computer)
    turn = Turn.new(computer_board)

    expect(turn.board).to eq computer_board
  end
end
