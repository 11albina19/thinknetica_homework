require_relative 'information'
require_relative 'instance_counter'

class Train
  include Information
  include InstanceCounter

  attr_accessor :wagons_array, :route, :speed
  attr_reader   :passenger, :name

  NAME_FORMAT = /^[а-яa-z0-9\d]{3}-?[а-яa-z0-9\d]{2}$/i

  @@trains = {}

  def self.find (name)
    @@trains[name]
  end

  def self.train (name, object)
    @@trains[name] = object
  end

  def initialize(name, passenger)
    @name          = name
    validate!
    @passenger     = passenger
    @wagons_array  = []
    @speed         = 0
    @index_station = 0
    self.class.train(name, self)
  end

  def show_trains
    self.wagons_array
  end

  def show_list_wagons(&block)
    return until block_given?
    wagons = show_trains
    wagons.each do |wagon|
      yield(wagon)
    end
  end

  def print_wagons_list
    show_list_wagons(&Train.block_wagons)
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

  def validate!
    raise "Input Error. Use letters and numbers in the format: XXX-XX/XXXXX" if @name !~ NAME_FORMAT
  end

class << self
  def block_wagons()
    ->(wagon) do
    case wagon.passenger
    when true
      all        = wagon.all_seats
      available  = wagon.show_available
    when false
      all        = wagon.all_volume
      available  = wagon.show_available
    end
    puts "#{wagon.number}, #{wagon.passenger}, общее количество мест/объема: #{all}, доступно: #{available}"
  end
  end
  end
end
