require_relative 'information'

class PassengerWagons
  include Information
  attr_reader :room, :passenger

  def initialize(room)
    @room      = room
    @passenger = true
  end
end
