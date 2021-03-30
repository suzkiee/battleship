class Cell
  attr_reader :coordinate,
              :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
  end

  def empty?
    return true if @ship == nil
    false
  end

  def place_ship(player_ship)
    @ship = player_ship
  end
end