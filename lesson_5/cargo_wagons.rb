class CargoWagons
  include Information::InstanceMethods
  attr_reader :room, :passenger

  def initialize(room)
    @room      = room
    @passenger = false
  end
end
