require_relative 'information'

class CargoWagons
  include Information
  attr_reader :room, :passenger

  def initialize(room)
    @room      = room
    @passenger = false
  end
end
