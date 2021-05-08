require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/shipyard'
require './lib/setup'
require './lib/turn'
require './lib/messages'
require './lib/user_input'
class Game

  def initialize(messages = Messages.new)
    @messages = messages
  end

  def play
    user_choice = main_menu
    while user_choice == 'p'
      computer = Setup.new(:computer).run_setup
      user = Setup.new(:user).run_setup
      take_turns(user, computer)
      celebrate_winner(user, computer)
      user_choice = main_menu
    end
    puts @messages.quit
  end

  def main_menu
    puts @messages.main_menu
    user_input = gets.chomp
    while user_input != 'p' && user_input != 'q'
      puts @messages.invalid_input
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
      puts @messages.user_wins
    else
      puts @messages.computer_wins
    end
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

  def display_boards(user, computer)
    puts @messages.computer_board_display
    puts computer.render
    puts @messages.user_board_display
    puts user.render(true)
    puts @messages.new_line
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
