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

  def render(is_transparent = false)
    if fired_upon? == false
      render_initial_cells(is_transparent)
    else
      render_impacted_cells
    end
  end

  def render_initial_cells(is_transparent)
    if is_transparent == true && empty? == false
      return '🛸' if ship.name == "🛸 UFO"
      '🚀'
    else
      '✨'
    end
  end

  def render_impacted_cells
    if empty? == false
      return '👾' if ship.sunk?
      '💥'
    else
      '💨'
    end
  end
end
