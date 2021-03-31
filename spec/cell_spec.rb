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

  describe '#render' do

    it 'returns a string' do
      cell = Cell.new("B4")

      expect(cell.render).is_a? String
    end

    it "returns '.' if cell has not been fired on and is empty" do
      cell = Cell.new("B4")
      
      expect(cell.fired_upon?).to eq false
      expect(cell.render(false)).to eq '.'
      expect(cell.render).to eq '.'
    end

    it "returns 'S' if cell has not been fired on and is not empty" do
      cell = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)
      cell.place_ship(cruiser)

      expect(cell.render(true)).to eq 'S'
    end
    
    it "returns 'H' if cell is fired upon and is not empty" do
      cell = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)
      cell.place_ship(cruiser)
      cell.fire_upon

      expect(cell.render).to eq 'H'
    end
  
   it "returns 'M' if cell is fired upon and is empty" do
      cell = Cell.new("B4")
      cell.fire_upon

      expect(cell.render).to eq 'M'
    end
  
   it "returns 'X' if cell is fired upon and the ship has sunk" do
      cell_1 = Cell.new("B4")
      cell_2 = Cell.new("B3")
      cell_3 = Cell.new("B2")
      cruiser = Ship.new("Cruiser", 3)
      cell_1.place_ship(cruiser)
      cell_2.place_ship(cruiser)
      cell_3.place_ship(cruiser)
      cell_1.fire_upon
      cell_2.fire_upon
      cell_3.fire_upon

      expect(cell_3.render).to eq 'X'
    end
  end
end
