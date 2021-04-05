class Turn

  attr_reader :computer, :user
  def initialize(computer, user)
    @computer = computer
    @user = user
  end

  def display_boards
    puts "=============COMPUTER BOARD============="
    puts computer.render
    puts "==============PLAYER BOARD=============="
    puts user.render(true)
  end

  
end
