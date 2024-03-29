require_relative 'information'
require_relative 'instance_counter'

class Train
  include Information
  include InstanceCounter

  attr_accessor :wagons_array, :route, :speed
  attr_reader   :passenger, :room

  @@trains = {}

  def self.find (room)
    @@trains[room]
  end

  def self.train (room, object)
    @@trains[room] = object
  end

  def initialize(room, passenger)
    @room          = room
    @passenger     = passenger
    @wagons_array  = []
    @speed         = 0
    @index_station = 0
    self.class.train(room, self)
  end

  def show_trains
    puts self.wagons_array
  end

  def to_brake
    puts 'Вагон затормозил'
    self.speed     = 0
  end

  def accelerate(increase)
    puts 'Вагон набирает скорость + ' + increase.to_s
    self.speed = self.speed + increase
  end

  def attach_wagons(wagons)
    if self.speed == 0 && self.passenger == wagons.passenger
      self.wagons_array << wagons
    end
  end

  def unhook_wagons(wagons)
    if self.speed == 0
      self.wagons_array.delete(wagons)
    end
  end

  def attach_route(route)
    @index_station = 0
    self.route  = route
    station = route.first
    station.to_accept_train(self)
  end

  #переместиться вперед
  def forward
    current_st = self.station_current()
    next_st = self.station_next()

    current_st.send_train (self)
    next_st.to_accept_train (self)

    @index_station = @index_station + 1
  end

  #переместиться назад
  def back
    current_st = self.station_current()
    previous_st = self.station_previous()

    current_st.send_train (self)
    previous_st.to_accept_train (self)

    @index_station = @index_station -1
  end

  private

  #методы ниже вызываются только из этого класса, поэтому не public
  #не private, т.к. используются в подклассах PassengerTrain и CargoTrain
  #предыдущая станция
  def station_previous
    self.route.stations[@index_station-1]
  end

  #текущая станция
  def station_current
    self.route.stations[@index_station]
  end

  #следующая станция
  def station_next
    self.route.stations[@index_station+1]
  end
end
