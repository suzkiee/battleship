class Turn

  attr_reader :user,
              :computer,
              :player_type

  def initialize(user, computer, player_typ, messages = Messages.new)
    @user        = user
    @computer    = computer
    @player_type = player_type
    @messages = messages
  end

  def take_turn(user, computer, player_type)
    if player_type == :computer
      computer_shoots(user)
    elsif player_type == :user
      user_shoots(computer)
    end
  end

  def validate_computer_shot(user, coordinate)
    while user.cells[coordinate].fired_upon? == true
      coordinate = random_coordinate(user)
    end
    coordinate
  end

  def user_shoots(computer)
    puts @messages.enter_coordinate
    print "> "
    coordinate = gets.chomp.upcase
    validated_shot = validate_user_shot(computer, coordinate)
    computer.cells[validated_shot].fire_upon
    shot_result(computer, validated_shot)
  end

  def validate_user_shot(computer, coordinate)
    while invalid?(computer, coordinate) || already_fired_on?(computer, coordinate)
      if invalid?(computer, coordinate)
        puts @messages.invalid_coordinate
      else
        puts @messages.already_fired_on
      end
      print "> "
      coordinate = gets.chomp.upcase
    end
    coordinate
  end

  def shot_result(player, coordinate, is_computer = false)
    print verify_player(coordinate, is_computer)
    puts result(player, coordinate)
  end

  private

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

    def random_coordinate(user)
      user.cells.keys.sample
    end

    def verify_player(coordinate, is_computer)
      if is_computer == true
        @messages.computer_result(coordinate)
      else
        @messages.user_result(coordinate)
      end
    end

    def result(player, coordinate)
      if player.cells[coordinate].render == '💨'
        @messages.shot_miss
      elsif player.cells[coordinate].render == '💥'
        @messages.shot_hit
      elsif player.cells[coordinate].render == '👾'
        @messages.shot_sunk
      end
    end
end
