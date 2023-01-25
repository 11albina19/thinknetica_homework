class PassengerWagons
  include Information::InstanceMethods
  attr_reader :room, :passenger

  def initialize(room)
    @room      = room
    @passenger = true
  end
end
