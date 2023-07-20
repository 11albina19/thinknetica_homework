require_relative 'instance_counter'

class Route
  attr_reader :first, :last, :stations
  include InstanceCounter

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
    for index in self.stations
      puts "Станция #{index.name}, #{index}, ИНДЕКС #{i}" 
      i = i + 1
    end
  end

  def validate!
    value = valid?
    raise "Value is not correct" if value == false
  end

  def valid?
    if (first.is_a? Station) && (last.is_a? Station)
      return true
    else
      return false
    end
  end
end
