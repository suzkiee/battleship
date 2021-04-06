class Game

  # celebrate_winner

  #game.play
    # => while input == p
    # complete_setup, take_turns, celebrate_winner
    # return to main menu when done
    # check input again, etc.

  attr_reader :user_board,
              :computer_board
  def initialize
    @computer_board = Board.new
    @user_board = Board.new
  end

  def main_menu
    puts "Welcome to BATTLESHIP 🛸"
    puts "Enter < p > to play. Enter < q > to quit."
    print "> "
    user_input = gets.chomp
    while user_input != 'p' && user_input != 'q'
      puts "Invalid input. Enter < p > to play. Enter < q > to quit."
      print "> "
      user_input = gets.chomp
    end
    user_input
  end

  def display_boards(user, computer)
    puts "=============COMPUTER BOARD============="
    puts computer.render
    puts "==============PLAYER BOARD=============="
    puts user.render(true)
  end

  # def play
  #   while main_menu == 'p'
  #     complete_computer_setup
  #     complete_user_setup
  #
  #   end
  # end

  def take_turns(user, computer)
    display_boards(user, computer)
    while winner?(user, computer) == false
      computer_turn = Turn.new(computer, user, :computer)
      computer_turn.take_turn(computer, user, :computer)
      display_boards(user, computer)
      break if winner?(user, computer) == true
      user_turn = Turn.new(computer, user, :human)
      user_turn.take_turn(computer, user, :human)
      display_boards(user, computer)
    end
  end

  def complete_computer_setup
    submarine = Ship.new("Submarine", 2)
    cruiser = Ship.new("Cruiser", 3)
    ships = [submarine, cruiser]
    computer_setup = Setup.new(@computer_board, ships, :computer)
    computer = computer_setup.run_setup
  end

  def complete_user_setup
    submarine = Ship.new("Submarine", 2)
    cruiser = Ship.new("Cruiser", 3)
    ships = [submarine, cruiser]
    user_setup = Setup.new(@user_board, ships, :human)
    user = user_setup.run_setup
  end

  def winner?(user, computer)
    check_for_winner(user, computer) != nil 
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
