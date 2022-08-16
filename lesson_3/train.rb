class Train

attr_reader :room

attr_reader :passenger

  def initialize (room, passenger, amount)
    @room      = room
    @passenger = passenger
    @amount    = amount
  end

end