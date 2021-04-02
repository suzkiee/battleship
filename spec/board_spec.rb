require 'rspec'
require './lib/board'
require './lib/cell'
require './lib/ship'

describe Board do

  describe '#initialize' do

    it 'exists' do
      board = Board.new
      expect(board).is_a? Board
    end

    it 'creates a hash with 16 Cell class objects' do
      board = Board.new

      expect(board.cells).is_a? Hash
      expect(board.cells.length).to eq 16
      expect(board.cells["A1"]).is_a? Cell
    end
  end

  describe '#valid_coordinate?' do

    it 'returns true if coordinate is valid' do
      board = Board.new

      expect(board.valid_coordinate?("A1")).to be true
    end

    it 'returns false if coordinate is not valid' do
      board = Board.new

      expect(board.valid_coordinate?("A22")).to be false
    end
  end

  describe '#all_coordinates_valid(placement_coordinates?' do

    it 'returns true if all coordinates are valid' do
      board = Board.new
      placement_coordinates = ['A1', 'A2', 'A3']

      expect(board.all_coordinates_valid?(placement_coordinates)).to be true
    end

    it 'returns false if any coordinates are not valid' do
      board = Board.new
      placement_coordinates = ['A1', 'A2', 'E3']

      expect(board.all_coordinates_valid?(placement_coordinates)).to be false
    end
  end

  describe '#valid_placement?' do

    it 'returns false if placement length is equal to length of ship' do
      board = Board.new
      submarine = Ship.new("Submarine", 2)
      cruiser = Ship.new("Cruiser", 3)

      expect(board.valid_placement?(submarine, ["A1", "A2", "A3"])).to be false
      expect(board.valid_placement?(cruiser, ["A1", "A2"])).to be false
    end

    it 'returns true if placement length is equal to length of ship' do
      board = Board.new
      submarine = Ship.new("Submarine", 2)
      cruiser = Ship.new("Cruiser", 3)

      expect(board.valid_placement?(submarine, ["A1", "A2"])).to be true
      expect(board.valid_placement?(cruiser, ["A1", "A2", "A3"])).to be true
    end

    it 'returns false if coordinates are not consecutive horizontally' do
      board = Board.new
      submarine = Ship.new("Submarine", 2)
      cruiser = Ship.new("Cruiser", 3)

      expect(board.valid_placement?(submarine, ["A2", "A4"])).to be false
      expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to be false
    end

    it 'returns false if horizontal coordinates do not increase consecutively' do
      board = Board.new
      submarine = Ship.new("Submarine", 2)
      cruiser = Ship.new("Cruiser", 3)

      expect(board.valid_placement?(submarine, ["A4", "A3"])).to be false
      expect(board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to be false
    end

    it 'returns true if coordinates are consecutive horizontally' do
      board = Board.new
      submarine = Ship.new("Submarine", 2)
      cruiser = Ship.new("Cruiser", 3)

      expect(board.valid_placement?(submarine, ["A1", "A2"])).to be true
      expect(board.valid_placement?(cruiser, ["A1", "A2", "A3"])).to be true
    end

    it 'returns false if coordinates are not consecutive vertically' do
      board = Board.new
      submarine = Ship.new("Submarine", 2)
      cruiser = Ship.new("Cruiser", 3)

      expect(board.valid_placement?(submarine, ["A1", "C1"])).to be false
      expect(board.valid_placement?(cruiser, ["A1", "C1", "D1"])).to be false
    end

    it 'returns false if vertical coordinates do not increase consecutively' do
      board = Board.new
      submarine = Ship.new("Submarine", 2)
      cruiser = Ship.new("Cruiser", 3)

      expect(board.valid_placement?(submarine, ["D1", "C1"])).to be false
      expect(board.valid_placement?(cruiser, ["D1", "C1", "B1"])).to be false
    end

    it 'returns true if coordinates are consecutive vertically' do
      board = Board.new
      submarine = Ship.new("Submarine", 2)
      cruiser = Ship.new("Cruiser", 3)

      expect(board.valid_placement?(submarine, ["B1", "C1"])).to be true
      expect(board.valid_placement?(cruiser, ["B1", "C1", "D1"])).to be true
    end

    it 'returns false if coordinates are diagonal' do
      board = Board.new
      submarine = Ship.new("Submarine", 2)
      cruiser = Ship.new("Cruiser", 3)

      expect(board.valid_placement?(submarine, ["C2", "D3"])).to be false
      expect(board.valid_placement?(cruiser, ["A1", "B2", "C3"])).to be false
    end

    it 'returns false if placement overlaps other ship' do
      board = Board.new
      submarine = Ship.new("Submarine", 2)
      cruiser = Ship.new("Cruiser", 3)
      cell_1 = board.cells["A1"] 
      cell_2 = board.cells["A2"] 
      cell_3 = board.cells["A3"] 
      expect(board.valid_placement?(submarine, ["A1", "B1"])).to be true
      
      board.place(cruiser, ["A1", "A2", "A3"])
      expect(board.valid_placement?(submarine, ["A1", "B1"])).to be false
    end

    it 'returns true if valid placement has no overlap' do
      board = Board.new
      submarine = Ship.new("Submarine", 2)
      cruiser = Ship.new("Cruiser", 3)
      cell_1 = board.cells["A1"] 
      cell_2 = board.cells["A2"] 
      cell_3 = board.cells["A3"] 
      
      board.place(cruiser, ["A1", "A2", "A3"])
      expect(board.valid_placement?(submarine, ["B1", "C1"])).to be true
    end
  end

  describe '#place' do
    it 'places ship in cells if placement is valid' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      board.place(cruiser, ["A1", "A2", "A3"])
      cell_1 = board.cells["A1"]
      cell_2 = board.cells["A2"]
      cell_3 = board.cells["A3"]

      expect(cell_1.ship).to eq cruiser
      expect(cell_2.ship).to eq cruiser
      expect(cell_3.ship).to eq cruiser
      expect(cell_1.ship).to eq cell_2.ship
    end

    it 'does not place ship in cells if placement is invalid' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      board.place(cruiser, ["A1", "A2", "A4"])
      cell_1 = board.cells["A1"]
      cell_2 = board.cells["A2"]
      cell_3 = board.cells["A4"]

      expect(cell_1.ship).to be_nil
      expect(cell_2.ship).to be_nil
      expect(cell_3.ship).to be_nil
    end
  end
end
