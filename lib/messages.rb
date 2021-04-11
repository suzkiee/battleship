class Messages

  def quit
    "\nWell, fine. Bye.\n"
  end

  def main_menu
    "\n\n        🛸 Welcome to BATTLESHIP 🛸" +
    "\nEnter < p > to play. Enter < q > to quit."
  end

  def invalid_input 
    "Invalid input. Enter < p > to play. Enter < q > to quit."
  end

  def user_wins
    "You won! Here's a trophy. 🏆\n\n"
  end

  def computer_wins
    "I won! No trophy for you. 🙅🏻‍♀️\n\n"
  end

  def computer_board_display
    "\n=============COMPUTER BOARD============="
  end

  def user_board_display
    "\n=============YOUR BOARD============="
  end

  def new_line
    "\n"
  end
end