require 'rspec'
require './lib/ship'

describe Ship do
  describe '#initialize' do
    cruiser = Ship.new("Cruiser", 3)

    it 'exists' do
      expect(cruiser).is_a? Ship
    end

    it 'returns ship name' do
      expect(cruiser.name).to eq "Cruiser"
    end

    it 'returns ship length' do
      expect(cruiser.length).to eq 3
    end

    it 'returns current health' do
      expect(cruiser.health).to eq 3
    end
  end

  describe '#sunk?' do
    cruiser = Ship.new("Cruiser", 3)

    it 'knows if ship has not sunk' do
      expect(cruiser.sunk?).to eq false
    end

    it 'knows if ship has sunk' do
      3.times do
        cruiser.hit
      end

      expect(cruiser.sunk?).to eq true
    end
  end

  describe '#hit' do
    cruiser = Ship.new("Cruiser", 3)

    it 'decreases ship health' do
      cruiser.hit

      expect(cruiser.health).to eq 2
    end
  end
end
