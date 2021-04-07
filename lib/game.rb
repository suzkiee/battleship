class Game

  attr_reader :user_board,
              :computer_board
  def initialize
    @computer_board = Board.new
    @user_board = Board.new
  end

  def play
    user_choice = main_menu
    while user_choice == 'p'
      computer = complete_computer_setup
      user = complete_user_setup
      take_turns(user, computer)
      celebrate_winner(user, computer)
      user_choice = main_menu
    end
    puts "Well, fine. Bye."
  end

  def main_menu
    puts "\n\nWelcome to BATTLESHIP 🛸"
    puts "\nEnter < p > to play. Enter < q > to quit."
    print "> "
    user_input = gets.chomp
    while user_input != 'p' && user_input != 'q'
      puts "Invalid input. Enter < p > to play. Enter < q > to quit."
      print "> "
      user_input = gets.chomp
    end
    user_input
  end

  def take_turns(user, computer)
    display_boards(user, computer)
    while winner?(user, computer) == false
      computer_turn = Turn.new(user, computer, :computer)
      computer_turn.take_turn(user, computer, :computer)
      display_boards(user, computer)
      break if winner?(user, computer) == true
      user_turn = Turn.new(user, computer, :user)
      user_turn.take_turn(user, computer, :user)
      display_boards(user, computer)
    end
  end

  def celebrate_winner(user, computer)
    if check_for_winner(user, computer) == user
      puts "You won! Here's a trophy. 🏆\n\n"
    else
      puts "I won! No trophy for you. 🙅🏻‍♀️\n\n"
    end
  end

  def complete_computer_setup
    ships = create_ships
    computer_setup = Setup.new(ships, @computer_board, :computer)
    computer = computer_setup.run_setup
  end

  def complete_user_setup
    ships = create_ships
    user_setup = Setup.new(ships, @user_board, :user)
    user = user_setup.run_setup
  end

  def create_ships
    ufo = Ship.new("UFO", 2)
    rocket = Ship.new("Rocket", 3)
    ships = [ufo, rocket]
  end

  def check_for_winner(user, computer)
    if all_ships_sunk?(computer)
      winner = user
    elsif all_ships_sunk?(user)
      winner = computer
    else
      winner = nil
    end
    winner
  end

  def winner?(user, computer)
    check_for_winner(user, computer) != nil
  end

  def display_boards(user, computer)
    puts "\n=============COMPUTER BOARD============="
    puts computer.render
    puts "\n ==============PLAYER BOARD=============="
    puts user.render(true)
    puts "\n"
  end

  def all_ships_sunk?(player)
    cells = player.cells.values
    cells_with_ships = cells.find_all do |cell|
      cell.empty? == false
    end

    if cells_with_ships.length == 0
      false
    else
      cells_with_ships.all? do |cell|
        cell.ship.sunk?
      end
    end
  end
end
