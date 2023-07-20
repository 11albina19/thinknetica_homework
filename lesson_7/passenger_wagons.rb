require_relative 'information'

class PassengerWagons
  include Information
  attr_reader :number, :passenger
  attr_accessor :all_seats, :busy_seats

  def initialize(number, all_seats)
    @number     = number
    @all_seats  = all_seats
    @passenger  = true
    @busy_seats = 0
    validate!
  end

  def validate!
    raise "Should be a positive number" unless @number.to_i > 0
  end

  def show_busy
    self.busy_seats
  end

  def show_available
    self.all_seats - self.busy_seats
  end

  def alter_seat_busy
    if self.busy_seats < self.all_seats
      self.busy_seats = self.busy_seats + 1
    end
  end

  def alter_seat_available
    if self.busy_seats > 0
      self.busy_seats = self.busy_seats - 1
    end
  end
end
