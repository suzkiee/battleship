class Board

  attr_reader :cells
  def initialize
    @cells = generate_cells
  end

  def generate_cells

    letters = ["A","B","C","D"].group_by do |letter|
      (1..4).collect {letter}
    end.keys

    numbers = (1..4).to_a.map do |number|
      number.to_s
    end

    keys = letters.map do |letter_array|
      letter_array.zip(numbers)
    end.flatten(1)

    string_keys = keys.map do |key|
      key.join
    end

    cells = Hash.new
    string_keys.each do |key|
      cells[key] = Cell.new(key)
    end
    
    cells
  end

  def valid_coordinate?(coordinate)
    cells.keys.include?(coordinate)
  end

  def all_coordinates_valid?(placement_coordinates)
    placement_coordinates.all? do |coordinate|
      valid_coordinate?(coordinate)
    end
  end

  ## Could we simplify the next 4 methods to make the horizonal/verical methods cleaner?
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

  def consecutive?(array)
    array.each_cons(2).all? do |num_1, num_2|
      num_2 == num_1 +1
    end
  end

  def correct_placement_length?(ship, placement_coordinates)
    ship.length == placement_coordinates.length
  end

  def all_cells_available?(placement_coordinates)
    placement_coordinates.all? do |coordinate|
      cells[coordinate].empty?
    end
  end

  def valid_placement?(ship, coordinates)
    all_coordinates_valid?(coordinates) &&
    correct_placement_length?(ship, coordinates) &&
    all_cells_available?(coordinates) &&
    ship_perpendicular?(coordinates)
  end

  def ship_perpendicular?(placement_coordinates)
    letters = letters(placement_coordinates)
    numbers = numbers(placement_coordinates)
    vertical = not_all_same?(letters) && all_same?(numbers) && consecutive?(letters)
    horizontal = all_same?(letters) && not_all_same?(numbers) && consecutive?(numbers)
    vertical || horizontal
  end

  def place(ship, placement_coordinates)
    if valid_placement?(ship, placement_coordinates)
      placement_coordinates.each do |coordinate|
        cells[coordinate].place_ship(ship)
      end
    end
  end

  def render_cells(is_transparent = false)
    rendered_cells = @cells.map do |coordinate, cell|
      cell.render(is_transparent)
    end

    rows = rendered_cells.each_slice(4).to_a
    rows.map do |row|
      row.join(' ')
    end
  end

  def create_row_hash(rows)
    row_letters = ("A".."D").to_a
    row_hash = row_letters.zip(rows).to_h
  end

  def render(is_transparent = false)
    rows = render_cells(is_transparent)
    row_hash = create_row_hash(rows)
    return "  1 2 3 4 \n" +
           "A #{row_hash["A"]} \n" +
           "B #{row_hash["B"]} \n" +
           "C #{row_hash["C"]} \n" +
           "D #{row_hash["D"]} \n"
  end
end
