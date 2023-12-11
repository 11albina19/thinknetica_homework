# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validation'

class Route
  include InstanceCounter
  include Validation

  attr_reader :first, :last, :stations

  validate :first, :type, Station
  validate :last,  :type, Station

  def initialize(first, last)
    @first        = first
    @last         = last
    @stations = [first, last]
    validate!
  end

  def add(station)
    @stations.insert(-2, station)
  end

  def delete(station)
    @stations.delete(station)
  end

  def show_all
    i = 0
    stations.each do |index|
      puts "Станция #{index.name}, #{index}, ИНДЕКС #{i}"
      i += 1
    end
  end
end
