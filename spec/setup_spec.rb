require 'rspec'
require './lib/board'
require './lib/cell'
require './lib/messages'
require './lib/ship'
require './lib/shipyard'
require './lib/setup'
require './lib/user_input'

describe Setup do

  describe '#initialize' do

    it 'exists' do
      setup = Setup.new(:computer)

      expect(setup).is_a? Setup
    end

    it 'knows who is playing' do
      setup = Setup.new(:computer)

      expect(setup.player_type).to eq :computer
    end
  end

  describe '#place_computer_ship' do
    it 'provides valid placement arrays for computer ships' do
      computer = Setup.new(:computer)
      board = computer.board
      ufo = computer.ships.first
      rocket = computer.ships.last
      ufo_placement = computer.place_computer_ship(ufo, board)
      rocket_placement = computer.place_computer_ship(rocket, board)

      expect(ufo_placement).is_a? Array
      expect(board.valid_placement?(ufo, ufo_placement)).to eq false
      expect(board.valid_placement?(rocket, rocket_placement)).to eq false
    end
  end

  describe '#user_setup_intro' do
    it 'returns the empty board' do
      user = Setup.new(:user)

      empty_board = "               1   2   3   4 \n" +
                    "            A ✨  ✨  ✨  ✨ \n" +
                    "            B ✨  ✨  ✨  ✨ \n" +
                    "            C ✨  ✨  ✨  ✨ \n" +
                    "            D ✨  ✨  ✨  ✨ \n"
      expect(user.user_setup_intro(user.ships, user.board)).to eq empty_board
    end
  end

  describe '#run_setup' do
    it 'return a board' do
      computer = Setup.new(:computer)

      expect(computer.run_setup).is_a? Board
    end
  end

  describe '#random_coordinates' do
    it 'returns the number of coordinates the ship needs' do
      setup = Setup.new(:computer)
      board = setup.board
      rocket = setup.ships.last

      actual = setup.random_coordinates(rocket, board).length
      expect(actual).to eq 3
    end
  end
end
