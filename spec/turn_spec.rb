require 'rspec'
require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/setup'
require './lib/turn'

describe Turn do

  describe '#initialize' do

    it 'exists' do
      computer_setup = Setup.new(:computer)
      computer = computer_setup.run_setup
      mock_user = instance_double("Board")

      turn = Turn.new(mock_user, computer, :user)

      expect(turn).is_a? Turn
    end

    it 'has a board' do
      computer_setup = Setup.new(:computer)
      computer = computer_setup.run_setup
      mock_user = instance_double("Board")

      turn = Turn.new(mock_user, computer, :computer)

      expect(turn.computer).to eq computer
    end

    it 'has a player type' do
      computer_setup = Setup.new(:computer)
      computer = computer_setup.run_setup
      mock_user = instance_double("Board")

      turn = Turn.new(mock_user, computer, :computer)

      expect(turn.player_type).to eq :computer
    end
  end

  describe '#take_turn' do

    it 'computer fires on user cell' do
      computer_setup = Setup.new(:computer)
      computer = computer_setup.run_setup
      mock_user = Board.new

      turn = Turn.new(mock_user, computer, :computer)
      allow(turn).to receive(:random_coordinate) {"A1"}
      turn.take_turn(mock_user, computer, :computer)

      expect(mock_user.cells["A1"].fired_upon?).to eq true
    end
  end

  describe '#validate_computer_shot' do

    it 'should take a bad coordinate and return a good coordinate' do
      user = Board.new
      computer = Board.new
      turn = Turn.new(user, computer, :computer)

      user.cells["A1"].fire_upon
      allow(turn).to receive(:random_coordinate) {"B2"}

      expect(turn.validate_computer_shot(user, "A1")).to eq "B2"
    end
  end
end
