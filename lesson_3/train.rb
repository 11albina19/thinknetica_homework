class Train

  attr_reader :room

  attr_reader :passenger

  attr_reader :amount

  attr_reader :speed

  attr_reader :route

  def initialize (room, passenger, amount)
    @room      = room
    @passenger = passenger
    @amount    = amount
    @speed     = 0
  end

  def to_brake ()
    puts 'Вагон затормозил'
    @speed     = 0
  end

  def accelerate (increase)
    puts 'Вагон набирает скорость + ' + increase.to_s
    @speed = @speed + increase
  end

  def attach_unhook (attach)
    if self.speed == 0
      if attach 
        @amount = @amount + 1
      else
        @amount = @amount - 1
      end
    end
  end

  def route= (route)
    @route  = route
    station = route.first
    station.to_accept_train(self)
  end

  def get_all()
    all = []
    all << @route.first
    for index in @route.intermediate
      all << index
    end
    all << @route.last
  end

#предыдущая станция
def station_previous()
  all = get_all()
  x = 0
  previous = nil
  for station in all
    array = station.train_array
    if array.size != 0
      there = array.include?(self)
      if there 
        previous = all[x-1]
        break
      end
    end
    x += x
  end
  previous
end

#текущая станция
def station_current()
  all = get_all()
  x = 0
  previous = nil
  for station in all
    array = station.train_array
    if array.size != 0
      there = array.include?(self)
      if there 
        previous = all[x]
        break
      end
    end
    x += x
  end
  previous
end

#следующая станция
def station_next()
  all = get_all()
  x = 0
  previous = nil
  for station in all
    array = station.train_array
    if array.size != 0
      there = array.include?(self)
      if there 
        previous = all[x+1]
        break
      end
    end
    x += x
  end
  previous
end

#переместиться вперед
def forward ()
  current_st = self.station_current()
  next_st = self.station_next()
  
  current_st.send_train (self)
  next_st.to_accept_train (self)
end

#переместиться назад
def back ()
  current_st = self.station_current()
  previous_st = self.station_previous()
  
  current_st.send_train (self)
  previous_st.to_accept_train (self)
end

end