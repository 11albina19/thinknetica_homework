require_relative 'information'

class CargoWagons
  include Information
  attr_reader :number, :passenger
  attr_accessor :all_volume, :busy_volume

  NAME_FORMAT = /^[a-zа-я\d\s]{1,20}$/i

  def initialize(number, all_volume)
    @number      = number
    @all_volume  = all_volume
    @busy_volume = 0
    @passenger   = false
    validate!
  end

  def validate!
    raise "Should be a positive number" unless @number.to_i > 0
  end

  def show_busy
    self.busy_volume
  end

  def show_available
    self.all_volume - self.busy_volume
  end

  def alter_volume_busy(value)
    result = self.busy_volume + value
    if result <= self.all_volume
      self.busy_volume = self.busy_volume + value
    end
  end

  def alter_volume_available(value)
    result = self.busy_volume - value
    if result >= 0
      self.busy_volume = self.busy_volume - value
    end
  end
end

