require_relative 'information'

class CargoWagons
  include Information
  attr_reader :room, :passenger

  def initialize(room)
    @room = room
    @passenger = false
    validate!
  end

  def validate!
    value = valid?
    raise "Value is not correct" if value == false
  end

  def valid?
    # if room.is_a? Integer
    #  return false
    # else
    #  true
    # end

    value = room.to_s

    # if value.nil? || value.length <
    if value.length < 3
      return false
    else
      true
    end
  end
end

