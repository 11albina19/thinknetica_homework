# frozen_string_literal: true

require_relative 'information'
require_relative 'instance_counter'

class Train
  include Information
  include InstanceCounter

  attr_accessor :wagon_array, :route, :speed
  attr_reader   :type, :name

  NAME_FORMAT = /^[а-яa-z0-9\d]{3}-?[а-яa-z0-9\d]{2}$/i.freeze

  @@trains = {}

  def self.find(name)
    @@trains[name]
  end

  def self.train(name, object)
    @@trains[name] = object
  end

  def initialize(name)
    @name = name
    validate!
    @wagon_array = []
    @speed         = 0
    @index_station = 0
    self.class.train(name, self)
  end

  def show_trains
    wagon_array
  end

  def show_list_wagon(&block)
    return until block_given?
    wagons = show_trains
    wagons.each(&block)
  end

  def print_wagon_list
    show_list_wagon(&Train.block_wagon)
  end

  def to_brake
    puts 'Вагон затормозил'
    self.speed = 0
  end

  def accelerate(increase)
    puts "Вагон набирает скорость + #{increase}"
    self.speed = speed + increase
  end

  def attach_wagon(wagon)
    return unless speed.zero? && type == wagon.type

    wagon_array << wagon
  end

  def unhook_wagon(wagon)
    return unless speed.zero?

    wagon_array.delete(wagon)
  end

  def attach_route(route)
    @index_station = 0
    self.route = route
    station = route.first
    station.to_accept_train(self)
  end

  # переместиться вперед
  def forward
    current_st = station_current
    next_st = station_next

    current_st.send_train(self)
    next_st.to_accept_train(self)

    @index_station += 1
  end

  # переместиться назад
  def back
    current_st = station_current
    previous_st = station_previous

    current_st.send_train(self)
    previous_st.to_accept_train(self)

    @index_station -= 1
  end

  private

  # методы ниже вызываются только из этого класса, поэтому не public
  # не private, т.к. используются в подклассах PassengerTrain и CargoTrain
  # предыдущая станция
  def station_previous
    route.stations[@index_station - 1]
  end

  # текущая станция
  def station_current
    route.stations[@index_station]
  end

  # следующая станция
  def station_next
    route.stations[@index_station + 1]
  end

  def validate!
    raise 'Input Error. Use letters and numbers in the format: XXX-XX/XXXXX' if @name !~ NAME_FORMAT
  end

  class << self
    def block_wagon
      lambda do |wagon|
        case wagon.type
        when :passenger
        when :cargo
        end
        puts "#{wagon.type}, общее количество мест/объема: #{wagon.total_place}, доступно: #{wagon.used_place}"
      end
    end
  end
end
