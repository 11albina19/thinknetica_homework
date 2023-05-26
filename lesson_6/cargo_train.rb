class CargoTrain < Train

  def initialize(name)
    @name          = name
    validate!
    @passenger     = false
    @wagons_array  = []
    @speed         = 0
    @index_station = 0
  end
end
