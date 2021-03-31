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
end
