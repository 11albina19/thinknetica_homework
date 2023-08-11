#require_relative 'information'

class Wagon
  #include Information
  attr_reader :type, :total_place, :used_place

  def initialize(total_place)
    @total_place  = total_place
    @used_place = 0
    validate!
  end

  def validate!
    raise "Should be a positive number" unless self.total_place.is_a? Integer
  end

  def free_place
    self.total_place - self.used_place
  end
end