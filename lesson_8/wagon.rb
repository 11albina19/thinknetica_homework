# frozen_string_literal: true

class Wagon
  attr_reader :type, :total_place, :used_place

  def initialize(total_place)
    @total_place = total_place
    @used_place = 0
    validate!
  end

  def validate!
    raise 'Should be a positive number' unless total_place.is_a? Integer
  end

  def free_place
    total_place - used_place
  end
end
