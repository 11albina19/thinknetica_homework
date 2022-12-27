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

  def show_all
    i = 0;
    for index in self.stations
      puts "Станция #{index.name}, #{index}, ИНДЕКС #{i}" 
      i = i + 1
    end
  end

end
