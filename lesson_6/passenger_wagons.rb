require_relative 'information'

class PassengerWagons
  include Information
  attr_reader :number, :passenger

  def initialize(number)
    @number     = number
    @passenger = true
    validate!
  end

  def validate!
    raise "Should be a positive number" unless @number.to_i > 0
  end
end
