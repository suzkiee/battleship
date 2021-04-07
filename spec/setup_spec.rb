require 'rspec'
require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/setup'

describe Setup do

  describe '#initialize' do

    it 'exists' do
      board = Board.new
      ufo = Ship.new("UFO", 2)
      rocket = Ship.new("Rocket", 3)
      ships = [ufo, rocket]
      setup = Setup.new(ships, board, :computer)

      expect(setup).is_a? Setup
    end

    it 'knows who is playing' do
      board = Board.new
      ufo = Ship.new("UFO", 2)
      rocket = Ship.new("Rocket", 3)
      ships = [ufo, rocket]
      setup = Setup.new(ships, board, :computer)

      expect(setup.player_type).to eq :computer
    end
  end

  describe '#place_computer_ship' do
    it 'provides valid placement arrays for computer ships' do
      board = Board.new
      ufo = Ship.new("UFO", 2)
      rocket = Ship.new("Rocket", 3)
      ships = [ufo, rocket]
      computer = Setup.new(ships, board, :computer)
      ufo_placement = computer.place_computer_ship(ufo, board)
      rocket_placement = computer.place_computer_ship(rocket, board)

      expect(ufo_placement).is_a? Array
      expect(board.valid_placement?(ufo, ufo_placement)).to eq false
      expect(board.valid_placement?(rocket, rocket_placement)).to eq false
    end
  end

  describe '#user_setup_intro' do

    it 'returns the empty board' do
      board = Board.new
      ufo = Ship.new("UFO", 2)
      rocket = Ship.new("Rocket", 3)
      ships = [ufo, rocket]
      user = Setup.new(ships, board, :user)

      empty_board = "               1   2   3   4 \n" +
                    "            A ✨  ✨  ✨  ✨ \n" +
                    "            B ✨  ✨  ✨  ✨ \n" +
                    "            C ✨  ✨  ✨  ✨ \n" +
                    "            D ✨  ✨  ✨  ✨ \n"
      expect(user.user_setup_intro(ships, board)).to eq empty_board
    end
  end

  describe '#run_setup' do
    it 'return a board' do
      board = Board.new
      ufo = Ship.new("UFO", 2)
      rocket = Ship.new("Rocket", 3)
      ships = [ufo, rocket]
      computer = Setup.new(ships, board, :computer)

      expect(computer.run_setup).is_a? Board
    end
  end

  describe '#random_coordinates' do
    it 'returns the number of coordinates the ship needs' do
      board = Board.new
      rocket = Ship.new("Rocket", 3)
      ships = [rocket]
      setup = Setup.new(ships, board, :computer)

      actual = setup.random_coordinates(rocket, board).length
      expect(actual).to eq 3
    end
  end
end
