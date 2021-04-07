require 'rspec'
require './lib/ship'

describe Ship do
  describe '#initialize' do
    rocket = Ship.new("Rocket", 3)

    it 'exists' do
      expect(rocket).is_a? Ship
    end

    it 'returns ship name' do
      expect(rocket.name).to eq "Rocket"
    end

    it 'returns ship length' do
      expect(rocket.length).to eq 3
    end

    it 'returns current health' do
      expect(rocket.health).to eq 3
    end
  end

  describe '#sunk?' do
    rocket = Ship.new("Rocket", 3)

    it 'knows if ship has not sunk' do
      expect(rocket.sunk?).to eq false
    end

    it 'knows if ship has sunk' do
      3.times do
        rocket.hit
      end

      expect(rocket.sunk?).to eq true
    end
  end

  describe '#hit' do
    rocket = Ship.new("Rocket", 3)

    it 'decreases ship health' do
      rocket.hit

      expect(rocket.health).to eq 2
    end
  end
end
