require_relative 'information'

class PassengerWagons
  include Information
  attr_reader :room, :passenger

  NAME_FORMAT = /^[a-zа-я\d\s]{1,20}$/i

  def initialize(room)
    @room      = room
    @passenger = true
    validate!
  end

  def validate!
    raise "Input error. To create a title, use only letters, numbers and spaces; the length of the title should not exceed 20 characters" if @room !~ NAME_FORMAT
  end
end
