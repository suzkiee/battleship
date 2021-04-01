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

  def valid_coordinate?(coordinate)
    cells.keys.include?(coordinate)
  end

  def valid_placement?(ship, cells)
    letters = cells.map do |cell| 
      cell.split('').first
    end

    numbers = cells.map do |cell|
      cell.split('').last
    end

    if ship.length == cells.length
      false 
    elsif letters.uniq.length == 1 || numbers.uniq.length ==  1
      
      if letters.uniq.length == 1 && numbers.uniq.length > 1
        # Check numbers to make sure they're consecutive
        # Return true if numbers are consecutive
        # False if not
      elsif letters.uniq.length > 1 && numbers.uniq.length == 1
        # Check letters to make sure they're consecutive
        # Return true if letters are consecutive
        # False if not
      else
        false 
      end
    
    else 
    end
    # Top Level: 
    # 1. All the letters are the same 
    # 2. All the numbers are the same

    #Second Level: 
    # 1. If all letters are same, the numbers need to be in order 
    # 2. If all the numbers are the same, the letters need to be in order 

    # Need an array of the numbers 
    # each_cons to check that each one is consecutive (each following value is +1 from the one before it.)
    
    # Need an array of letters
    
  end

end
