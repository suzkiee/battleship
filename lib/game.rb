class Game

  # take_turns method

  #check_for_winner method

  # celebrate_winner

  #game.play
    # => while input == p
    # complete_setup, take_turns, celebrate_winner
    # return to main menu when done
    # check input again, etc.
  def initialize
    @computer_board = Board.new
    @user_board = Board.new
    @submarine = Ship.new("Submarine", 2)
    @cruiser = Ship.new("Cruiser", 3)
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

  # def play
  #   while main_menu == 'p'
  #     complete_computer_setup
  #     complete_user_setup
  #
  #   end
  # end

  def complete_computer_setup
    ships = [@submarine, @cruiser]
    computer_setup = Setup.new(@computer_board, ships, :computer)
    computer = computer_setup.run_setup
  end

  def complete_user_setup
    ships = [@submarine, @cruiser]
    user_setup = Setup.new(@user_board, ships, :human)
    user = user_setup.run_setup
  end






end
