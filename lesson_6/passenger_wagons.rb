require_relative 'information'

class PassengerWagons
  include Information
  attr_reader :room, :passenger

  def initialize(room)
    @room      = room
    @passenger = true
    validate!
  end

  def validate!
    value = valid?
    raise "Value is not correct" if value == false
  end

  def valid?
    if room.is_a? Integer
      return false
    else
      true
    end
    if room.nil? || room.length < 3
      return false
    else
      true
    end
  end
end
