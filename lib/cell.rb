class Cell
  attr_reader :coordinate,
              :ship,
              :fired_upon

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    return true if @ship == nil
    false
  end

  def place_ship(player_ship)
    @ship = player_ship
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    if @ship != nil 
      ship.hit 
      @fired_upon = true
    else
      @fired_upon = true
    end
  end
end