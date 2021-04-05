class Turn

  attr_reader :computer, :user
  def initialize(computer, user)
    @computer = computer
    @user = user
  end

  def display_boards
    puts "=============COMPUTER BOARD============="
    puts computer.render
    puts "==============PLAYER BOARD=============="
    puts user.render(true)
  end

  def user_shoots(computer)
    puts "Enter coordinate for your shot: "
    print "> "
    coordinate = gets.chomp
    validated_shot = validate_user_shot(computer, coordinate)
    computer.cells[validated_shot].fire_upon
    shot_result(computer, validated_shot)
  end

  def validate_user_shot(computer, coordinate)
    while computer.valid_coordinate?(coordinate) == false
      puts "Please enter a valid coordinate: "
      print "> "
      coordinate = gets.chomp
    end
    already_fired_on_computer?(computer, coordinate)
    coordinate
  end

  def already_fired_on_computer?(computer, coordinate)
    while computer.cells[coordinate].fired_upon?
      puts "Please enter a valid coordinate: "
      print "> "
      coordinate = gets.chomp
    end
    coordinate
  end

  # def user_shot_result(player, coordinate)
  #   if player.cells[coordinate].render == 'M'
  #     puts "Your shot on #{coordinate} was a miss."
  #   elsif player.cells[coordinate].render == 'H'
  #     puts "Your shot on #{coordinate} was a hit!"
  #   elsif player.cells[coordinate].render == 'X'
  #     puts "Your shot on #{coordinate} was a hit. You sunk my battleship!"
  #   end
  # end


  def shot_result(player, coordinate, is_computer = false)
    if is_computer == true 
      print "My " 
    else 
      print "Your "
    end

    if player.cells[coordinate].render == 'M'
      puts "shot on #{coordinate} was a miss."
    elsif player.cells[coordinate].render == 'H'
      puts "shot on #{coordinate} was a hit!"
    elsif player.cells[coordinate].render == 'X'
      puts "shot on #{coordinate} was a hit. You sunk my battleship!"
    end
  end

  def computer_shoots(user)
    coordinate = user.cells.keys.sample 
    validated_shot = validate_computer_shot(user, coordinate)
    user.cells[validated_shot].fire_upon
    shot_result(user, validated_shot, true)
  end

  def validate_computer_shot(user, coordinate)
    while user.valid_coordinate?(coordinate) == false
      coordinate = user.cells.keys.sample
    end
    already_fired_on_user?(user, coordinate)
    coordinate
  end
  
  def already_fired_on_user?(user, coordinate)
    while user.cells[coordinate].fired_upon?
      coordinate = user.cells.keys.sample
    end
    coordinate
  end

  # def shot_result(player, coordinate, self = true)
  #   if player.cells[coordinate].render == 'M'
  #     puts "My shot on #{coordinate} was a miss."
  #   elsif player.cells[coordinate].render == 'H'
  #     puts "My shot on #{coordinate} was a hit!"
  #   elsif player.cells[coordinate].render == 'X'
  #     puts "My shot on #{coordinate} was a hit. You sunk my battleship!"
  #   end
  # end
end
