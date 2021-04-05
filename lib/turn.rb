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

  # player takes shot
  # puts intro statement
  # gets.chomp shot
  # validate_shot(board, coordinate)

  def user_shoots(computer)
    puts "Enter coordinate for your shot: "
    p "> "
    coordinate = gets.chomp
    validated_shot = validate_user_shot(computer, coordinate)
    computer.cells[validated_shot].fire_upon
    shot_result(computer, validated_shot)
  end

  def validate_user_shot(computer, coordinate)
    while computer.valid_coordinate?(coordinate) == false
      puts "Please enter a valid coordinate: "
      p "> "
      coordinate = gets.chomp
    end
    already_fired_on?(computer, coordinate)
    coordinate
  end

  def already_fired_on?(computer, coordinate)
    while computer.cells[coordinate].fired_upon?
      puts "Please enter a valid coordinate: "
      p "> "
      coordinate = gets.chomp
    end
    coordinate
  end

  def shot_result(player, coordinate)
    if player.cells[coordinate].render == 'M'
      puts "Your shot on #{coordinate} was a miss."
    elsif player.cells[coordinate].render == 'H'
      puts "Your shot on #{coordinate} was a hit!"
    elsif player.cells[coordinate].render == 'X'
      puts "Your shot on #{coordinate} was a hit. You sunk my battleship!"
    end
  end
end
