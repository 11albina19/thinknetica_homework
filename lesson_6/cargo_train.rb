class CargoTrain < Train

  def initialize(room)
    @room          = room
    validate!
    @passenger     = false
    @wagons_array  = []
    @speed         = 0
    @index_station = 0
  end
end
