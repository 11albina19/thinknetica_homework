require_relative 'information'

class CargoWagons
  include Information
  attr_reader :number, :passenger

  NAME_FORMAT = /^[a-zа-я\d\s]{1,20}$/i

  def initialize(number)
    @number     = number
    @passenger = true
    validate!
  end

  def validate!
    raise "Should be a positive number" unless @number.to_i > 0
  end
end

