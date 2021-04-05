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

      expect(submarine_placement).is_a? Array
      expect(board.valid_placement?(submarine, submarine_placement)).to eq false
      expect(board.valid_placement?(cruiser, cruiser_placement)).to eq false
    end
  end

  describe '#player_setup_intro' do
    
    it 'returns the empty board' do
      board = Board.new
      submarine = Ship.new("Submarine", 2)
      cruiser = Ship.new("Cruiser", 3)
      ships = [submarine, cruiser]
      user = Setup.new(board, ships, :human)

      empty_board =  "  1 2 3 4 \n" +
                     "A . . . . \n" +
                     "B . . . . \n" +
                     "C . . . . \n" +
                     "D . . . . \n"
      expect(user.player_setup_intro(board, ships)).to eq empty_board
    end
  end

  describe '#player_place_ship' do
    
    it 'gives valid placement' do
      board = Board.new
      submarine = Ship.new("Submarine", 2)
      cruiser = Ship.new("Cruiser", 3)
      ships = [submarine, cruiser]
      user = Setup.new(board, ships, :human)
      coordinates = ['A1', 'A2', 'A3']
      # come back to test user input 

      expect(user.board.valid_placement?(cruiser, coordinates)).to eq true
    end
  end

  describe '#run_setup' do
    it 'return a board' do
      board = Board.new
      submarine = Ship.new("Submarine", 2)
      cruiser = Ship.new("Cruiser", 3)
      ships = [submarine, cruiser]
      user = Setup.new(board, ships, :human)

      expect(user.run_setup).is_a? Board
    end
  end
end
