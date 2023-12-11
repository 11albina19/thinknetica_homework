# frozen_string_literal: true

require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'station'
require_relative 'route'
require_relative 'wagon'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'

class RailRoad
  MENU_FIRST_ITEM = 0
  MENU_LAST_ITEM = 12
  EXIT_ACTION = 99

  attr_reader :exit_action_num, :stations, :trains, :wagons, :routes

  MENU = [
    { number: 0, message: 'Список команд', action: :show_menu },
    { number: 1, message: 'Создать станцию', action: :create_station },
    { number: 2, message: 'Создать поезд', action: :create_train },
    { number: 3, message: 'Создать вагон', action: :create_wagon },
    { number: 4, message: 'Создать маршрут', action: :create_route },
    { number: 5, message: 'Управлять станциями на маршруте (добавлять, удалять)',
      action: :add_stations_to_route },
    { number: 6, message: 'Назначить маршрут поезду', action: :assign_route },
    { number: 7, message: 'Изменить состав вагонов у поезда', action: :change_wagons },
    { number: 8, message: 'Перемеcтить поезд по маршруту', action: :move_train },
    { number: 9, message: 'Список вагонов у поезда', action: :print_wagons_list },
    { number: 10, message: 'Список поездов на станции', action: :print_trains_list },
    { number: 11, message: 'Занять место/ объем в вагоне', action: :occupy_seat_and_volume_wagons },
    { number: 12, message: 'Информация по всем созданным объектам', action: :show },
    { number: 99, message: 'Завершить выполнение программы', action: :exit }
  ].freeze

  def initialize
    @stations = []
    @trains = []
    @wagons = []
    @routes = []
    @menu = MENU
    @exit_action_num = EXIT_ACTION
  end

  def menu
    show_menu
  end

  def show_menu
    @menu.each do |item|
      puts "#{item[:number]}: #{item[:message]}"
    end
  end

  def action_input
    loop do
      print 'выполнить команду: '
      action_num = gets.chomp.to_i
      return action_num if (action_num >= MENU_FIRST_ITEM && action_num <= MENU_LAST_ITEM) || action_num == EXIT_ACTION
    end
  end

  def get_action(action_num)
    menu_item = @menu.find do |m|
      m[:number] == action_num
    end
    menu_item[:action]
  end

  def show
    puts '-------------------------------------------------------------------'
    puts 'Созданные станции и поезда на каждой из них:'
    @stations.each do |index|
      puts "Станция #{index.name}"
      index.show_trains
    end
    puts 'Все созданные вагоны:'
    puts @wagons
    puts 'Все созданные поезда:'
    puts @trains
    puts 'Все созданные маршруты:'
    puts @routes
  end

  def create_station
    puts 'Как назвать станцию?'
    name = gets.chomp
    station = Station.new(name)
    @stations << station
    puts "Создана станция #{station.name} !"
  rescue StandardError => e
    puts e.message
    retry
  end

  def create_train
    affempf = 0
    begin
      puts 'Это пассажирский поезд? 1 - пассажирский, 2 - грузовой'
      train_type = gets.chomp.to_i
      puts 'Введите наименование поезда в формате 3 буквы или цифры, необязательный дефис и еще 2 буквы или цифры'
      train_name = gets.chomp.to_s
      if train_type == 1
        train = PassengerTrain.new(train_name)
        @trains << train
        puts "Создан поезд #{train.name}"
      elsif train_type == 2
        train = CargoTrain.new(train_name)
        @trains << train
        puts "Создан поезд #{train.name}"
      else
        puts 'Неверный тип поезда'
      end
    rescue StandardError => e
      affempf += 1
      puts e.message
      retry if affempf < 3
    end
  end

  def create_wagon
    affempf = 0
    begin
      puts 'Это пассажирский вагон? 1 - пассажирский, 2 - грузовой'
      wagon_type = gets.chomp.to_i
      if wagon_type == 1
        puts 'Введите количество мест в вагоне'
        total_place = gets.chomp.to_i
        if total_place.positive?
          wagon = PassengerWagon.new(total_place)
          @wagons << wagon
          puts "Создан вагон #{wagon}"
        else
          puts 'Ошибка при указании количества мест'
         end
      elsif wagon_type == 2
        puts 'Введите общий объем вагона'
        total_place = gets.chomp.to_i
        if total_place.positive?
          wagon = CargoWagon.new(total_place)
          @wagons << wagon
          puts "Создан вагон #{wagon}"
        else
          puts 'Ошибка при указании общего объема'
        end
      else
        puts 'Неверный тип вагона'
      end
    rescue StandardError => e
      affempf += 1
      puts "Validation failed: #{e.message}"
      retry if affempf < 3
    end
  end
end

def create_route
  puts 'Перед вами список всех доступных станций:'
  show_all_station
  attempf = 0
  begin
    puts 'Введите индекс начальной станции маршрута'
    index_begin = gets.chomp.to_i
    begin_selection_error = type_check(stations, index_begin)
    return if begin_selection_error

    puts 'Введите индекс конечной станции маршрута'
    index_end = gets.chomp.to_i
    end_selection_error = type_check(stations, index_end)
    return if end_selection_error

    route = Route.new(stations[index_begin], stations[index_end])
    @routes << route
    puts 'Создан маршрут! Его станции: '
    route.show_all
  rescue StandardError => e
    attempf += 1
    puts e.message
    retry if attempf < 3
  end
end

def add_stations_to_route
  puts 'Какое изменение требуется? 1 - добавить станцию, 2 - удалить станцию'
  number = gets.chomp.to_i
  puts 'Перед вами список всех доступных маршрутов:'
  show_all_route
  puts 'Введите индекс выбранного маршрута:'
  index_route = gets.chomp.to_i
  route_selection_error = type_check(routes, index_route)
  return if route_selection_error

  puts 'Перед вами список всех доступных станций:'
  show_all_station
  puts 'Введите индекс выбранной станции'
  index_station = gets.chomp.to_i
  station_selection_error = type_check(stations, index_station)
  return if station_selection_error

  if number == 1
    routes[index_route].add(stations[index_station])
  elsif number == 2
    routes[index_route].delete(stations[index_station])
  end
  puts 'Станции маршрута после изменения:'
  routes[index_route].show_all
end

def assign_route
  puts 'Перед вами список всех доступных поездов:'
  show_all_train
  puts 'Введите индекс выбранного поезда:'
  index_train = gets.chomp.to_i
  train_selection_error = type_check(trains, index_train)
  return if train_selection_error

  puts 'Перед вами список всех доступных маршрутов:'
  show_all_route
  puts 'Введите индекс выбранного маршрута:'
  index_route = gets.chomp.to_i
  route_selection_error = type_check(routes, index_route)
  return if route_selection_error

  trains[index_train].attach_route(routes[index_route])
  puts "Поезду #{trains[index_train].name}, пассажирский: #{trains[index_train]},"
  puts "назначен маршрут #{routes[index_route]}"
end

def change_wagons
  puts 'Какое изменение требуется? 1 - добавить вагон, 2 - удалить вагон'
  number = gets.chomp.to_i
  puts 'Перед вами список всех доступных поездов:'
  show_all_train
  puts 'Введите индекс выбранного поезда:'
  index_train = gets.chomp.to_i
  train_selection_error = type_check(trains, index_train)
  return if train_selection_error

  puts 'Перед вами список всех доступных вагонов:'
  show_all_wagons
  puts 'Введите индекс выбранного вагона'
  index_wagons = gets.chomp.to_i
  wagons_selection_error = type_check(wagons, index_wagons)
  return if wagons_selection_error

  if number == 1
    trains[index_train].attach_wagon(wagons[index_wagons])
  elsif number == 2
    trains[index_train].unhook_wagon(wagons[index_wagons])
  end
end

def occupy_seat_and_volume_wagons
  puts 'Перед вами список всех доступных вагонов:'
  show_all_wagons
  puts 'Введите индекс выбранного вагона'
  index_wagons = gets.chomp.to_i
  wagons_selection_error = type_check(wagons, index_wagons)
  return if wagons_selection_error

  wagon = wagons[index_wagons]
  if wagon.type == :passenger
    puts "Выбран пассажирский вагон #{wagon}, ИНДЕКС #{index_wagons}"
    puts "Общее количество мест в нем #{wagon.total_place}, из них свободно #{wagon.free_place}"
    puts 'Нажмите 1 - занять место; 2 - освободить место'
    number_change = gets.chomp.to_i
    case number_change
    when 1
      wagon.take_place
    when 2
      wagon.give_place
    end
    puts "Действие завершено. Cвободных мест #{wagon.free_place}, занято #{wagon.used_place}"
  else
    puts "Выбран грузовой вагон #{wagon}, ИНДЕКС #{index_wagons}"
    puts "Общий объем в нем #{wagon.total_place}, доступный объем #{wagon.free_place}"
    puts 'Нажмите 1 - занять объем; 2 - освободить объем'
    number_change = gets.chomp.to_i
    case number_change
    when 1
      puts 'Введите, какое количество объема необходимо занять'
      value = gets.chomp.to_i
      wagon.take_place(value)
    when 2
      puts 'Введите, какое количество объема необходимо освободить'
      value = gets.chomp.to_i
      wagon.give_place(value)
    end
    puts "Действие завершено. Теперь доступный объем #{wagon.free_place}, из общего количества занято #{wagon.used_place}"
  end
end

def print_wagons_list
  puts 'Перед вами список всех доступных поездов:'
  show_all_train
  puts 'Введите индекс выбранного поезда:'
  index_train = gets.chomp.to_i
  train_selection_error = type_check(trains, index_train)
  return if train_selection_error

  trains[index_train].print_wagon_list
end

def print_trains_list
  puts 'Перед вами список всех доступных станций:'
  show_all_station
  puts 'Введите индекс выбранной станции'
  index_station = gets.chomp.to_i
  station_selection_error = type_check(stations, index_station)
  return if station_selection_error

  stations[index_station].print_trains_list
end

def move_train
  puts 'Какое перемещение поезда требуется? 1 - вперед, 2 - назад'
  number = gets.chomp.to_i
  puts 'Перед вами список всех доступных поездов:'
  show_all_train
  puts 'Введите индекс выбранного поезда:'
  index_train = gets.chomp.to_i
  train_selection_error = type_check(trains, index_train)
  return if train_selection_error

  if number == 1
    trains[index_train].forward
  elsif number == 2
    trains[index_train].back
  end
end

def show_all_station
  stations.each_with_index do |station, index|
    puts "Станция #{station.name}, ИНДЕКС #{index}"
  end
end

def show_all_train
  trains.each_with_index do |train, index|
    puts "Поезд #{train.name}, тип: #{train.type}, ИНДЕКС #{index}"
  end
end

def show_all_wagons
  wagons.each_with_index do |wagon, index|
    puts "Вагон #{wagon}, тип: #{wagon.type}, ИНДЕКС #{index}"
  end
end

def show_all_route
  routes.each_with_index do |_route, index|
    puts "Маршрут, ИНДЕКС #{index}"
  end
end

def type_check(array, index)
  element = array[index]
  error = element.nil?
  puts 'Ошибка в выборе элемента! Выполняется возврат в предыдущее меню...' if error
  error
end

game = RailRoad.new
game.menu
#============= main loop ==============
loop do
  action_num = game.action_input
  break if action_num == game.exit_action_num

  action = game.get_action(action_num)
  puts "--- #{game.menu.find { |m| m[:number] == action_num }[:message]} ---"
  game.send(action)
end