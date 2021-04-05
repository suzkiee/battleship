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
end
