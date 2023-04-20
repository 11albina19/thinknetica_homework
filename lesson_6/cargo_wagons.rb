require_relative 'information'

class CargoWagons
  include Information
  attr_reader :room, :passenger

  def initialize(room)
    #valid?
    @room      = room
    @passenger = false
    valid?
    #raise "Stop, stop, stop!"
  end

  def valid?
    #validate!
    Math.sqrt(-1)
    true
  rescue
    false
  end

  def validate!
    #value = room
    #raise "Room can't be nil" if value.nil?
    #if value.is_a? Integer
    #  value.to_s
    #end
    #raise "Room should be at least 3 symbols" if value.length < 3
    raise "Stop, stop, stop!"
  end
end
