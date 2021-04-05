require 'rspec'
require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/setup'
require './lib/turn'

describe Turn do
  describe '#initialize' do
    it 'exists' do
      board = Board.new
      submarine = Ship.new("Submarine", 2)
      cruiser = Ship.new("Cruiser", 3)
      ships = [submarine, cruiser]
      computer_setup = Setup.new(board, ships, :computer)
      computer = computer_setup.run_setup

      user_setup = Setup.new(board, ships, :human)
      user = user_setup.run_setup

      turn = Turn.new(computer, user)

      expect(turn).is_a? Turn
    end

    it 'has a board' do
      board = Board.new
      submarine = Ship.new("Submarine", 2)
      cruiser = Ship.new("Cruiser", 3)
      ships = [submarine, cruiser]
      computer_setup = Setup.new(board, ships, :computer)
      computer = computer_setup.run_setup

      user_setup = Setup.new(board, ships, :human)
      user = user_setup.run_setup

      turn = Turn.new(computer, user)

      expect(turn.computer).to eq computer
    end
  end
end
