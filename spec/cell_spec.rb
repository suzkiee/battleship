require 'rspec'
require './lib/cell'
require './lib/ship'

describe Cell do

  describe '#initialize' do
    it 'exists' do
      cell = Cell.new("B4")

      expect(cell).is_a? Cell
    end

    it 'has a coordinate' do
      cell = Cell.new("B4")

      expect(cell.coordinate).to eq "B4"
    end

    it 'returns nil when no ship is present' do
      cell = Cell.new("B4")
      
      expect(cell.ship).to eq nil
    end
  end

  describe '#empty?' do

    it 'returns true when no ship is present' do
      cell = Cell.new("B4")

      expect(cell.empty?).to eq true  
    end

    it 'returns false when a ship is present' do
      cell = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)
      cell.place_ship(cruiser)

      expect(cell.empty?).to eq false
    end
  end

  describe '#place_ship' do
    it 'places a ship in the cell' do
      cell = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)
      cell.place_ship(cruiser)

      expect(cell.ship).to eq cruiser
    end
  end

  describe '#fired_upon?' do
    it 'returns false if ship has not been hit' do
      cell = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)
      cell.place_ship(cruiser)

      expect(cell.fired_upon?).to eq false
    end
  end

  describe '#fire_upon' do
    it 'recognizes it has been fired upon' do
      cell = Cell.new("B4")
      cell.fire_upon

      expect(cell.fired_upon?).to eq true
    end

    it 'hits the ship' do
      cell = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)
      cell.place_ship(cruiser)
      cell.fire_upon

      expect(cell.fired_upon).to eq true
      expect(cell.ship.health).to eq 2
    end
  end
end 