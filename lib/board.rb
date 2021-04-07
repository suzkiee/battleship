class Board

  attr_reader :cells
  def initialize
    @cells = generate_cells
  end

  def generate_cells
    letters = create_coordinate_letters 
    numbers = create_coordinate_numbers
    keys = create_keys(letters, numbers)
    create_hash(keys)
  end
  
  def create_coordinate_letters 
    letters = ["A","B","C","D"].group_by do |letter|
      (1..4).collect {letter}
    end
    letters.keys
  end

  def create_coordinate_numbers
    numbers = (1..4).to_a.map do |number|
      number.to_s
    end
  end

  def create_hash(keys)
    cells = Hash.new
    keys.each do |key|
      cells[key] = Cell.new(key)
    end
    cells
  end

  def create_keys(letters, numbers)
    keys = letters.map do |letter_array|
      letter_array.zip(numbers)
    end

    string_keys = keys.flatten(1).map do |key|
      key.join
    end
  end

  def valid_placement?(ship, coordinates)
    all_coordinates_valid?(coordinates) &&
    correct_placement_length?(ship, coordinates) &&
    all_cells_available?(coordinates) &&
    ship_perpendicular?(coordinates)
  end

  def all_coordinates_valid?(coordinates)
    coordinates.all? do |coordinate|
      valid_coordinate?(coordinate)
    end
  end

  def ship_perpendicular?(coordinates)
    letters = letters(coordinates)
    numbers = numbers(coordinates)
    vertical = not_all_same?(letters) && all_same?(numbers) && consecutive?(letters)
    horizontal = all_same?(letters) && not_all_same?(numbers) && consecutive?(numbers)
    vertical || horizontal
  end

  def correct_placement_length?(ship, coordinates)
    ship.length == coordinates.length
  end

  def all_cells_available?(coordinates)
    coordinates.all? do |coordinate|
      cells[coordinate].empty?
    end
  end

  def place(ship, coordinates)
    if valid_placement?(ship, coordinates)
      coordinates.each do |coordinate|
        cells[coordinate].place_ship(ship)
      end
    end
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

  def valid_coordinate?(coordinate)
    cells.keys.include?(coordinate)
  end

  def letters(coordinates)
    coordinates.map do |coordinate|
       coordinate.split('').first.ord
    end
  end

  def numbers(coordinates)
    coordinates.map do |coordinate|
      coordinate.split('').last.to_i
    end
  end

  def consecutive?(elements)
    elements.each_cons(2).all? do |num_1, num_2|
      num_2 == num_1 +1
    end
  end

  def all_same?(elements)
    elements.uniq.length == 1
  end

  def not_all_same?(elements)
    elements.uniq.length > 1
  end
end
