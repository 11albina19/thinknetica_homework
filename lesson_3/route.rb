class Route
  attr_reader :first, :last, :stations

  def initialize(first, last)
    @first        = first
    @last         = last
    @stations = [first, last]
  end

  def add(station)
    @stations.insert(-2, station)
  end

  def delete(station)
    @stations.delete(station)
  end

  def show_all()
    puts self.stations
  end

end
