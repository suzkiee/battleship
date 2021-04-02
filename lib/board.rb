class Board

  attr_reader :cells
  def initialize
    @cells = {
               "A1" => Cell.new("A1"),
               "A2" => Cell.new("A2"),
               "A3" => Cell.new("A3"),
               "A4" => Cell.new("A4"),
               "B1" => Cell.new("B1"),
               "B2" => Cell.new("B2"),
               "B3" => Cell.new("B3"),
               "B4" => Cell.new("B4"),
               "C1" => Cell.new("C1"),
               "C2" => Cell.new("C2"),
               "C3" => Cell.new("C3"),
               "C4" => Cell.new("C4"),
               "D1" => Cell.new("D1"),
               "D2" => Cell.new("D2"),
               "D3" => Cell.new("D3"),
               "D4" => Cell.new("D4")
              }
  end
  # looping through - nested loop for expansion
  # should the methods below be a placement class?

  def valid_coordinate?(coordinate)
    cells.keys.include?(coordinate)
  end

  def all_coordinates_valid?(placement_coordinates)
    placement_coordinates.all? do |coordinate|
      valid_coordinate?(coordinate)
    end
  end

  def all_same?(array)
    array.uniq.length == 1
  end

  def not_all_same?(array)
    array.uniq.length > 1
  end

  def letters(placement_coordinates)
    placement_coordinates.map do |coordinate|
       coordinate.split('').first.ord
    end
  end

  def numbers(placement_coordinates)
    placement_coordinates.map do |coordinate|
      coordinate.split('').last.to_i
    end
  end

  def ship_diagonal?(placement_coordinates)
    letters = letters(placement_coordinates)
    numbers = numbers(placement_coordinates)
    not_all_same?(letters) && not_all_same?(numbers)
  end

  def ship_horizontal?(placement_coordinates)
    letters = letters(placement_coordinates)
    numbers = numbers(placement_coordinates)
    all_same?(letters) && not_all_same?(numbers)
  end

  def ship_vertical?(placement_coordinates)
    letters = letters(placement_coordinates)
    numbers = numbers(placement_coordinates)
    not_all_same?(letters) && all_same?(numbers)
  end

  def consecutive?(array)
    array.each_cons(2).all? do |num_1, num_2|
      num_2 == num_1 +1
    end
  end

  def correct_placement_length?(ship, placement_coordinates)
    ship.length == placement_coordinates.length
  end

  def all_cells_available?(placement_coordinates) 
    # iterate through placement coordinates and check that the cells are empty?

    placement_coordinates.all? do |coordinate|
      cells[coordinate].empty?
    end
  end

  # consider renaming
  def is_good_placement?(ship, placement_coordinates)
    all_coordinates_valid?(placement_coordinates) && correct_placement_length?(ship, placement_coordinates) && all_cells_available?(placement_coordinates)
  end

  def valid_placement?(ship, cells)
    if is_good_placement?(ship, cells) == false
      false
    elsif ship_diagonal?(cells)
      false
    elsif ship_horizontal?(cells)
      numbers = numbers(cells)
      consecutive?(numbers)
    elsif ship_vertical?(cells)
      letters = letters(cells)
      consecutive?(letters)
    end
  end

  def place(ship, placement_coordinates)
    if valid_placement?(ship, placement_coordinates)
      placement_coordinates.each do |coordinate|
        cells[coordinate].place_ship(ship)
      end
    end
    #may need to add error/return value for non placement
  end
end
