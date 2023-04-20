class PassengerTrain < Train

  def initialize(room)
    @room          = room
    @passenger     = true
    @wagons_array  = []
    @speed         = 0
    @index_station = 0
  end

end
