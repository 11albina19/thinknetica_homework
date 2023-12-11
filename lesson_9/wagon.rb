# frozen_string_literal: true
require_relative 'validation'

class Wagon
  include Validation

  attr_reader :type, :total_place, :used_place

  validate :total_place, :type, Integer

  def initialize(total_place)
    @total_place = total_place
    @used_place = 0
    #puts self.class.validations.inspect
    validate!
  end

  def free_place
    total_place - used_place
  end
end
