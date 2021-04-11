require 'rspec'
require './lib/user_input.rb'

describe UserInput do
  user_input = UserInput.new

  it 'accepts user input for one coordinate' do
    allow(user_input).to receive(:gets) {"a1"}

    expect(user_input.get_input).to eq "A1"
  end
end
