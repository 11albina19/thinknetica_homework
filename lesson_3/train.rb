class Train
  attr_reader :passenger, :amount, :route, :room, :speed

  def initialize(room, passenger, amount)
    @room          = room
    @passenger     = passenger
    @amount        = amount
    @speed         = 0
    @index_station = 0
  end

  def to_brake()
    puts 'Вагон затормозил'
    @speed     = 0
  end

  def accelerate(increase)
    puts 'Вагон набирает скорость + ' + increase.to_s
    @speed = @speed + increase
  end

  def attach()
    if self.speed == 0
      @amount = @amount + 1
    end
  end

  def unhook()
    if self.speed == 0
      @amount = @amount - 1
    end
  end

  def attach_route(route)
    @index_station = 0
    @route  = route
    station = route.first
    station.to_accept_train(self)
  end

#предыдущая станция
def station_previous()
  @route.stations[@index_station-1]
end

#текущая станция
def station_current()
  @route.stations[@index_station]
end

#следующая станция
def station_next()
  @route.stations[@index_station+1]
end

#переместиться вперед
def forward()
  current_st = self.station_current()
  next_st = self.station_next()

  current_st.send_train (self)
  next_st.to_accept_train (self)
end

#переместиться назад
def back()
  current_st = self.station_current()
  previous_st = self.station_previous()

  current_st.send_train (self)
  previous_st.to_accept_train (self)
end

end
