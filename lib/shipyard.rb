class Shipyard
  def self.create_ships
    ufo = Ship.new("🛸 UFO", 2)
    rocket = Ship.new("🚀 Rocket", 3)
    ships = [ufo, rocket]
  end
end
