class CargoTrain < Train

  def initialize(room)
    @room          = room
    @passenger     = false
    @wagons_array  = []
    @speed         = 0
    @index_station = 0
    validate!
  end
end
