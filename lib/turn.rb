class Turn

  attr_reader :user,
              :computer,
              :player_type

  def initialize(user, computer, player_type)
    @user        = user
    @computer    = computer
    @player_type = player_type
  end

  def take_turn(user, computer, player_type)
    if player_type == :computer
      computer_shoots(user)
    elsif player_type == :user
      user_shoots(computer)
    end
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
    while invalid?(computer, coordinate) || already_fired_on?(computer, coordinate)
      if invalid?(computer, coordinate)
        puts "That was an invalid coordinate. Please enter a valid coordinate: "
      else
        puts "You already fired on this coordinate. Try another: "
      end
      print "> "
      coordinate = gets.chomp
    end
    coordinate
  end

  def invalid?(computer, coordinate)
    computer.valid_coordinate?(coordinate) == false
  end

  def already_fired_on?(computer, coordinate)
    computer.cells[coordinate].fired_upon? == true
  end

  def computer_shoots(user)
    coordinate = random_coordinate(user)
    validated_shot = validate_computer_shot(user, coordinate)

    user.cells[validated_shot].fire_upon
    shot_result(user, validated_shot, true)
  end

  def validate_computer_shot(user, coordinate)
    while user.cells[coordinate].fired_upon? == true
      coordinate = random_coordinate(user)
    end
    coordinate
  end

  def random_coordinate(user)
    user.cells.keys.sample
  end

  def shot_result(player, coordinate, is_computer = false)
    if is_computer == true
      print "My shot on #{coordinate} was a "
    else
      print "Your shot on #{coordinate} was a "
    end

    if player.cells[coordinate].render == 'M'
      puts "miss."
    elsif player.cells[coordinate].render == 'H'
      puts "hit!"
    elsif player.cells[coordinate].render == 'X'
      puts "hit! ‍☠️  The ship was sunk. ☠️"
    end
  end
end
