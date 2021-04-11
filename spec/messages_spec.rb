require 'rspec'
require './lib/messages'

describe Messages do

  describe '#quit' do
    it 'returns a quit message' do
      message = Messages.new

      expect(message.quit).to eq "\nWell, fine. Bye.\n"
    end
  end
end