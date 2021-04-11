require 'rspec'
require './lib/messages'

describe Messages do
  message = Messages.new

  it 'returns a quit message' do
    expect(message.quit).to eq "\nWell, fine. Bye.\n"
  end

  it 'returns the main menu' do
    expected = "\n\n        🛸 Welcome to BATTLESHIP 🛸" +
                "\nEnter < p > to play. Enter < q > to quit.\n> "
    
    expect(message.main_menu).to eq expected
  end

  it 'returns invalid input message' do
    expected = "Invalid input. Enter < p > to play. Enter < q > to quit.\n> "
                
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
end