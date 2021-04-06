require 'rspec'
require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/setup'
require './lib/turn'
require './lib/game'

describe Game do
  describe '#initialize' do
    it 'exists' do
      game = Game.new

      expect(game).is_a? Game
    end
  end

  describe '#all_ships_sunk?' do
    it 'returns true if all of player\'s ships are sunk' do
      game = Game.new
      submarine = Ship.new("Submarine", 2)
      cruiser = Ship.new("Cruiser", 3)
      game.user_board.place(cruiser, ["A1", "A2", "A3"])
      game.user_board.place(submarine, ["B1", "B2"])
      cell_1 = game.user_board.cells["A1"]
      cell_2 = game.user_board.cells["A2"]
      cell_3 = game.user_board.cells["A3"]
      cell_1.fire_upon
      cell_2.fire_upon
      cell_3.fire_upon
      cell_4 = game.user_board.cells["B1"]
      cell_5 = game.user_board.cells["B2"]
      cell_4.fire_upon
      cell_5.fire_upon

      expect(game.all_ships_sunk?(game.user_board)).to eq true
    end
  end
end
