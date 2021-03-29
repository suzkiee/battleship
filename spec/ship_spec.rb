require 'rspec'
require './lib/ship'

describe Ship do
  describe '#initialize' do
    it 'exists' do
      cruiser = Ship.new("Cruiser", 3)

      expect(cruiser).is_a? Ship
    end

    it 'returns ship name' do
      cruiser = Ship.new("Cruiser", 3)

      expect(cruiser.name).to eq "Cruiser"
    end

    it 'returns ship length' do
      cruiser = Ship.new("Cruiser", 3)

      expect(cruiser.length).to eq 3
    end

    it 'returns current health' do
      cruiser = Ship.new("Cruiser", 3)

      expect(cruiser.health).to eq 3
    end
  end

  describe '#sunk?' do
    it 'knows if ship has not sunk' do
      cruiser = Ship.new("Cruiser", 3)

      expect(cruiser.sunk?).to eq false
    end

    it 'knows if ship has sunk' do
      cruiser = Ship.new("Cruiser", 3)
      3.times do
        cruiser.hit
      end

      expect(cruiser.sunk?).to eq true
    end
  end

  describe '#hit' do
    it 'decreases ship health' do
      cruiser = Ship.new("Cruiser", 3)
      cruiser.hit

      expect(cruiser.health).to eq 2
    end
  end
end
