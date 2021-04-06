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
      computer_setup = Setup.new(ships, board, :computer)
      computer = computer_setup.run_setup

      # user_setup = Setup.new(board, ships, :user)
      # user = user_setup.run_setup

      turn = Turn.new(user, computer, player_type)

      expect(turn).is_a? Turn
    end

    it 'has a board' do
      board = Board.new
      submarine = Ship.new("Submarine", 2)
      cruiser = Ship.new("Cruiser", 3)
      ships = [submarine, cruiser]
      computer_setup = Setup.new(ships, board, :computer)
      computer = computer_setup.run_setup

      # user_setup = Setup.new(ships, board, :user)
      # user = user_setup.run_setup

      turn = Turn.new(user, computer, player_type)

      expect(turn.computer).to eq computer
    end

    it 'has a player type' do
      board = Board.new
      submarine = Ship.new("Submarine", 2)
      cruiser = Ship.new("Cruiser", 3)
      ships = [submarine, cruiser]
      computer_setup = Setup.new(ships, board, :computer)

      turn = Turn.new(user, computer, player_type)

      expect(turn.player_type).to eq :computer
    end
  end

  describe '#validate_computer_shot' do
    it 'should take a bad coordinate and return a good coordinate' do
      user = Board.new
      computer = Board.new
      turn = Turn.new(user, computer, :computer)

      user.cells["A1"].fire_upon
      allow(turn).to receive(:random_coordinate) {"B2"}

      expect(turn.already_fired_on_user?(user, "A1")).to eq "B2"
    end
  end
end
