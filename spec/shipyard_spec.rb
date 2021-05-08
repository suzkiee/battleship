require 'rspec'
require './lib/ship'
require './lib/shipyard'

describe Shipyard do
  describe '#create_ships' do
    it 'creates default ships' do
      actual = Shipyard.create_ships
      expect(actual[0].name).to eq "🛸 UFO"
      expect(actual[1].name).to eq "🚀 Rocket"
    end
  end
end
