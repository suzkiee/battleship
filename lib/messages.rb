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

  def enter_coordinate
    "Enter coordinate for your shot: "
  end

  def invalid_coordinate
    "That was an invalid coordinate. Please enter a valid coordinate: "
  end

  def already_fired_on 
    "You already fired on this coordinate. Try another: "
  end

  def shot_miss
    "miss."
  end

  def shot_hit
    "hit!"
  end

  def shot_sunk
    "hit! ‍☠️  The ship was destroyed. ☠️"
  end

  def computer_result(coordinate)
    "My shot on #{coordinate} was a "
  end


  def user_result(coordinate)
    "\nYour shot on #{coordinate} was a "
  end

  def user_setup_intro
    "\nOkay, I've placed my ships. I hope you're ready for this." +
    "\nYou now need to place your own ships. Here's your fleet:\n"
  end

  def ship_details(ship)
    "         #{ship.name}: #{ship.length} units long"
  end

  def request_coordinates(ship)
    "\nEnter the coordinates for #{ship.name} (#{ship.length} spaces, format: A1 B1 ):"
  end

  def invalid_placement
    "Nope! That's not a valid placement. Try again:"
  end
end