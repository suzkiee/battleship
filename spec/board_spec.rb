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
  end

  describe '#generate_cells' do
    it 'creates a hash with 16 Cell class objects' do
      board = Board.new

      expect(board.generate_cells).is_a? Hash
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

  describe '#all_coordinates_valid(coordinates?' do

    it 'returns true if all coordinates are valid' do
      board = Board.new
      coordinates = ['A1', 'A2', 'A3']

      expect(board.all_coordinates_valid?(coordinates)).to be true
    end

    it 'returns false if any coordinates are not valid' do
      board = Board.new
      coordinates = ['A1', 'A2', 'E3']

      expect(board.all_coordinates_valid?(coordinates)).to be false
    end
  end

  describe '#valid_placement?' do

    it 'returns false if placement length is equal to length of ship' do
      board = Board.new
      ufo = Ship.new("UFO", 2)
      rocket = Ship.new("Rocket", 3)

      expect(board.valid_placement?(ufo, ["A1", "A2", "A3"])).to be false
      expect(board.valid_placement?(rocket, ["A1", "A2"])).to be false
    end

    it 'returns true if placement length is equal to length of ship' do
      board = Board.new
      ufo = Ship.new("UFO", 2)
      rocket = Ship.new("Rocket", 3)

      expect(board.valid_placement?(ufo, ["A1", "A2"])).to be true
      expect(board.valid_placement?(rocket, ["A1", "A2", "A3"])).to be true
    end

    it 'returns false if coordinates are not consecutive horizontally' do
      board = Board.new
      ufo = Ship.new("UFO", 2)
      rocket = Ship.new("Rocket", 3)

      expect(board.valid_placement?(ufo, ["A2", "A4"])).to be false
      expect(board.valid_placement?(rocket, ["A1", "A2", "A4"])).to be false
    end

    it 'returns false if horizontal coordinates do not increase consecutively' do
      board = Board.new
      ufo = Ship.new("UFO", 2)
      rocket = Ship.new("Rocket", 3)

      expect(board.valid_placement?(ufo, ["A4", "A3"])).to be false
      expect(board.valid_placement?(rocket, ["A3", "A2", "A1"])).to be false
    end

    it 'returns true if coordinates are consecutive horizontally' do
      board = Board.new
      ufo = Ship.new("UFO", 2)
      rocket = Ship.new("Rocket", 3)

      expect(board.valid_placement?(ufo, ["A1", "A2"])).to be true
      expect(board.valid_placement?(rocket, ["A1", "A2", "A3"])).to be true
    end

    it 'returns false if coordinates are not consecutive vertically' do
      board = Board.new
      ufo = Ship.new("UFO", 2)
      rocket = Ship.new("Rocket", 3)

      expect(board.valid_placement?(ufo, ["A1", "C1"])).to be false
      expect(board.valid_placement?(rocket, ["A1", "C1", "D1"])).to be false
    end

    it 'returns false if vertical coordinates do not increase consecutively' do
      board = Board.new
      ufo = Ship.new("UFO", 2)
      rocket = Ship.new("Rocket", 3)

      expect(board.valid_placement?(ufo, ["D1", "C1"])).to be false
      expect(board.valid_placement?(rocket, ["D1", "C1", "B1"])).to be false
    end

    it 'returns true if coordinates are consecutive vertically' do
      board = Board.new
      ufo = Ship.new("UFO", 2)
      rocket = Ship.new("Rocket", 3)

      expect(board.valid_placement?(ufo, ["B1", "C1"])).to be true
      expect(board.valid_placement?(rocket, ["B1", "C1", "D1"])).to be true
    end

    it 'returns false if coordinates are diagonal' do
      board = Board.new
      ufo = Ship.new("UFO", 2)
      rocket = Ship.new("Rocket", 3)

      expect(board.valid_placement?(ufo, ["C2", "D3"])).to be false
      expect(board.valid_placement?(rocket, ["A1", "B2", "C3"])).to be false
    end

    it 'returns false if placement overlaps other ship' do
      board = Board.new
      ufo = Ship.new("UFO", 2)
      rocket = Ship.new("Rocket", 3)
      cell_1 = board.cells["A1"]
      cell_2 = board.cells["A2"]
      cell_3 = board.cells["A3"]
      expect(board.valid_placement?(ufo, ["A1", "B1"])).to be true

      board.place(rocket, ["A1", "A2", "A3"])
      expect(board.valid_placement?(ufo, ["A1", "B1"])).to be false
    end

    it 'returns true if valid placement has no overlap' do
      board = Board.new
      ufo = Ship.new("UFO", 2)
      rocket = Ship.new("Rocket", 3)
      cell_1 = board.cells["A1"]
      cell_2 = board.cells["A2"]
      cell_3 = board.cells["A3"]

      board.place(rocket, ["A1", "A2", "A3"])
      expect(board.valid_placement?(ufo, ["B1", "C1"])).to be true
    end
  end

  describe '#place' do
    it 'places ship in cells if placement is valid' do
      board = Board.new
      rocket = Ship.new("Rocket", 3)
      board.place(rocket, ["A1", "A2", "A3"])
      cell_1 = board.cells["A1"]
      cell_2 = board.cells["A2"]
      cell_3 = board.cells["A3"]

      expect(cell_1.ship).to eq rocket
      expect(cell_2.ship).to eq rocket
      expect(cell_3.ship).to eq rocket
      expect(cell_1.ship).to eq cell_2.ship
    end

    it 'does not place ship in cells if placement is invalid' do
      board = Board.new
      rocket = Ship.new("Rocket", 3)
      board.place(rocket, ["A1", "A2", "A4"])
      cell_1 = board.cells["A1"]
      cell_2 = board.cells["A2"]
      cell_3 = board.cells["A4"]

      expect(cell_1.ship).to be_nil
      expect(cell_2.ship).to be_nil
      expect(cell_3.ship).to be_nil
    end
  end

  describe '#render' do
    it 'returns String' do
      board = Board.new

      expect(board.render).is_a? String
    end

    it 'prints rendered cells' do
      board = Board.new

      empty_board = "               1   2   3   4 \n" +
                  "            A ✨  ✨  ✨  ✨ \n" +
                  "            B ✨  ✨  ✨  ✨ \n" +
                  "            C ✨  ✨  ✨  ✨ \n" +
                  "            D ✨  ✨  ✨  ✨ \n"
      expect(board.render).to eq empty_board
    end

    it "renders cells as 'M' if empty and fired upon" do
      board = Board.new
      cell_1 = board.cells["A1"]
      cell_1.fire_upon

      empty_board = "               1   2   3   4 \n" +
                  "            A 💨  ✨  ✨  ✨ \n" +
                  "            B ✨  ✨  ✨  ✨ \n" +
                  "            C ✨  ✨  ✨  ✨ \n" +
                  "            D ✨  ✨  ✨  ✨ \n"
      expect(board.render).to eq empty_board
    end

    it "renders cells as 'H' if fired upon and contains a floating ship" do
      board = Board.new
      rocket = Ship.new("Rocket", 3)
      board.place(rocket, ["A1", "A2", "A3"])
      cell_1 = board.cells["A1"]
      cell_2 = board.cells["A2"]
      cell_3 = board.cells["A3"]
      cell_1.fire_upon

      new_board = "               1   2   3   4 \n" +
                  "            A 💥  ✨  ✨  ✨ \n" +
                  "            B ✨  ✨  ✨  ✨ \n" +
                  "            C ✨  ✨  ✨  ✨ \n" +
                  "            D ✨  ✨  ✨  ✨ \n"
      expect(board.render).to eq new_board
    end

    it "renders cells as 'X' if fired upon and contains a sunken ship" do
      board = Board.new
      rocket = Ship.new("Rocket", 3)
      board.place(rocket, ["A1", "A2", "A3"])
      cell_1 = board.cells["A1"]
      cell_2 = board.cells["A2"]
      cell_3 = board.cells["A3"]
      cell_1.fire_upon
      cell_2.fire_upon
      cell_3.fire_upon

      new_board = "               1   2   3   4 \n" +
                  "            A 👾  👾  👾  ✨ \n" +
                  "            B ✨  ✨  ✨  ✨ \n" +
                  "            C ✨  ✨  ✨  ✨ \n" +
                  "            D ✨  ✨  ✨  ✨ \n"
      expect(board.render).to eq new_board
    end

    it "renders cells as 'S' if cell contains a ship and board is transparent" do
      board = Board.new
      rocket = Ship.new("Rocket", 3)
      board.place(rocket, ["A1", "A2", "A3"])
      cell_1 = board.cells["A1"]
      cell_2 = board.cells["A2"]
      cell_3 = board.cells["A3"]

      new_board = "               1   2   3   4 \n" +
                  "            A 🚀  🚀  🚀  ✨ \n" +
                  "            B ✨  ✨  ✨  ✨ \n" +
                  "            C ✨  ✨  ✨  ✨ \n" +
                  "            D ✨  ✨  ✨  ✨ \n"
      expect(board.render(true)).to eq new_board
    end
  end
end
