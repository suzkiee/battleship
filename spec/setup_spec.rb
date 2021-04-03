require 'rspec'
require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/setup'

describe Setup do

  describe '#initialize' do
    
    it 'exists' do
      board = Board.new
      submarine = Ship.new("Submarine", 2)
      cruiser = Ship.new("Cruiser", 3)
      ships = [submarine, cruiser]
      setup = Setup.new(board, ships, :computer)

      expect(setup).is_a? Setup
    end

    it 'knows who is playing' do
      board = Board.new
      submarine = Ship.new("Submarine", 2)
      cruiser = Ship.new("Cruiser", 3)
      ships = [submarine, cruiser]
      setup = Setup.new(board, ships, :computer)

      expect(setup.player).to eq :computer
    end
  end

  describe '#place_computer_ship' do
    
    it 'provides valid placement arrays for computer ships' do
      #computer randomly selects array of cells for each ship until it get valid placement.
      board = Board.new
      submarine = Ship.new("Submarine", 2)
      cruiser = Ship.new("Cruiser", 3)
      ships = [submarine, cruiser]
      computer = Setup.new(board, ships, :computer)
      submarine_placement = computer.place_computer_ship(submarine, board)
      cruiser_placement = computer.place_computer_ship(cruiser, board)

      expect(computer.place_computer_ship(submarine, board)).is_a? Array
      expect(board.valid_placement?(submarine, submarine_placement)).to eq true
      expect(board.valid_placement?(cruiser, cruiser_placement)).to eq true
    end

  end
end
