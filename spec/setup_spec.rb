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
      setup = Setup.new(board, ships)

      expect(setup).is_a? Setup
    end
  end

  # describe '#setup_board' do
  #
  # end
end
