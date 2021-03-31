class Cell
  attr_reader :coordinate,
              :ship,
              :fired_upon

  def initialize(coordinate)
    @coordinate = coordinate
    @ship       = nil
    @fired_upon = false
  end

  def empty?
    @ship == nil
  end

  def place_ship(player_ship)
    @ship = player_ship
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    ship.hit if @ship != nil
    @fired_upon = true
  end

  def render(is_transparent = false )
    if fired_upon? == false 
      return 'S' if is_transparent == true && empty? == false
      '.'
    else 
      if empty? == false
        return 'X' if ship.sunk?
        'H'
      else 
        'M'
      end
    end
  end
end
