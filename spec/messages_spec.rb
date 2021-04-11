require 'rspec'
require './lib/messages'

describe Messages do
  message = Messages.new

  it 'returns a quit message' do
    expect(message.quit).to eq "\nWell, fine. Bye.\n"
  end

  it 'returns the main menu' do
    expected = "\n\n        🛸 Welcome to BATTLESHIP 🛸" +
                "\nEnter < p > to play. Enter < q > to quit."
    
    expect(message.main_menu).to eq expected
  end

  it 'returns invalid input message' do
    expected = "Invalid input. Enter < p > to play. Enter < q > to quit."
                
    expect(message.invalid_input).to eq expected
  end

  it 'returns user as winner' do
    expected = "You won! Here's a trophy. 🏆\n\n"
                
    expect(message.user_wins).to eq expected
  end

  it 'returns computer as winner' do
    expected = "I won! No trophy for you. 🙅🏻‍♀️\n\n"
                
    expect(message.computer_wins).to eq expected
  end

  it 'displays computer board header' do
    expected = "\n=============COMPUTER BOARD============="
                
    expect(message.computer_board_display).to eq expected
  end

  it 'displays user board header' do
    expected = "\n=============YOUR BOARD============="
                
    expect(message.user_board_display).to eq expected
  end

  it 'adds new line' do
    expected = "\n"
                
    expect(message.new_line).to eq expected
  end

  it 'asks for coordinate' do
    expected = "Enter coordinate for your shot: "
                
    expect(message.enter_coordinate).to eq expected
  end

  it 'asks for new coordinate' do
    expected = "That was an invalid coordinate. Please enter a valid coordinate: "
                
    expect(message.invalid_coordinate).to eq expected
  end

  it 'notifies user that coordinate was fired on' do
    expected = "You already fired on this coordinate. Try another: "
                
    expect(message.already_fired_on).to eq expected
  end

  it 'returns miss' do
    expected = "miss."
                
    expect(message.shot_miss).to eq expected
  end

  it 'returns hit' do
    expected = "hit!"
                
    expect(message.shot_hit).to eq expected
  end

  it 'returns sunk' do
    expected = "hit! ‍☠️  The ship was destroyed. ☠️"
                
    expect(message.shot_sunk).to eq expected
  end

  it 'returns computer shot result' do
    coordinate = 'A1'
    expected = "My shot on #{coordinate} was a "
                
    expect(message.computer_result(coordinate)).to eq expected
  end

  it 'returns user shot result' do
    coordinate = 'A1'
    expected = "\nYour shot on #{coordinate} was a "
                
    expect(message.user_result(coordinate)).to eq expected
  end
end