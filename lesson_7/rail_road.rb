require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'station'
require_relative 'route'
require_relative 'passenger_wagons'
require_relative 'cargo_wagons'

class RailRoad
  attr_reader :stations, :trains, :wagons, :routes

  def initialize
    @stations = []
    @trains = []
    @wagons = []
    @routes = []
  end

  def menu
    number = 0
    while number != 4 do
      puts "-------------------------------------------------------------------"
      puts "Введите 1, если вы хотите создать станцию, поезд, вагон или маршрут"
      puts "Введите 2, если вы хотите произвести операции с созданными объектами"
      puts "Введите 3, если вы хотите вывести текущие данные о объектах"
      puts "Введите 4, если хотите закончить программу"
      number = gets.chomp.to_i
      case number
      when 1
        puts "-------------------------------------------------------------------"
        puts "Введите 0, если вы хотите создать станцию"
        puts "Введите 1, если вы хотите создать поезд"
        puts "Введите 2, если вы хотите создать вагон"
        puts "Введите 3, если вы хотите создать маршрут"
        puts "Введите 4 для возврата в предыдущее меню"
        number_create = gets.chomp.to_i
        case number_create
        when 0
          create_station
        when 1
          create_train
        when 2
          create_wagons
        when 3
          create_route
        when 4
          next
        else
          puts "Номер не определен. Выполнение программы завершено."
          break
        end
      when 2
        puts "-------------------------------------------------------------------"
        puts "Введите 0, если вы хотите добавить/удалить станции в существующий маршрут"
        puts "Введите 1, если вы хотите назначить маршрут поезду"
        puts "Введите 2, если вы хотите изменить состав вагонов у поезда"
        puts "Введите 3, чтобы вывести список вагонов у поезда"
        puts "Введите 4, чтобы занять место или объем в вагоне"
        puts "Введите 5, чтобы вывести список поездов на станции"
        puts "Введите 6, если вы хотите переместить поезд по маршруту"
        puts "Введите 7 для возврата в предыдущее меню"
        number_change = gets.chomp.to_i
        case number_change
        when 0
          add_stations_to_route
        when 1
          assign_route
        when 2
          change_wagons
        when 3
          print_wagons_list
        when 4
          occupy_seat_and_volume_wagons
        when 5
          print_trains_list
        when 6
          move_train
        when 7
          next
        else
          puts "Номер не определен. Выполнение программы завершено."
          break
        end
      when 3
        puts "-------------------------------------------------------------------"
        puts "Созданные станции и поезда на каждой из них:"
        for index in @stations
          puts "Станция #{index.name}"
          index.show_trains
        end
      when 4
        puts "Выполнение программы завершено."
        break
      else
        puts "Номер не определен. Выполнение программы завершено."
        break
      end
    end
  end

  def create_station
    begin
      puts "Как назвать станцию?"
      name = gets.chomp
      station = Station.new(name)
      @stations << station
      puts "Создана станция " + station.name + " !"
    rescue => e
      puts e.message
      retry
    end
  end

  def create_train
    affempf = 0
    begin
      puts "Это пассажирский поезд? 1 - пассажирский, 2 - грузовой"
      train_type = gets.chomp.to_i
      puts "Введите наименование поезда в формате 3 буквы или цифры, необязательный дефис и еще 2 буквы или цифры"
      train_name = gets.chomp.to_s
      if train_type == 1
        train = PassengerTrain.new(train_name)
        @trains << train
        puts "Создан поезд " + train.name.to_s
      elsif train_type == 2
        train = CargoTrain.new(train_name)
        @trains << train
        puts "Создан поезд " + train.name.to_s
      else
        puts "Неверный тип поезда"
      end
    rescue => e
      affempf = affempf + 1
      puts e.message
      retry if affempf < 3
    end
  end

  def create_wagons
    affempf = 0
    begin
      puts "Это пассажирский вагон? 1 - пассажирский, 2 - грузовой"
      wagon_type = gets.chomp.to_i
      puts "Введите номер вагона"
      wagon_number = gets.chomp.to_i
      if wagon_type == 1
        puts "Введите количество мест в вагоне"
        all_seats = gets.chomp.to_i
        wagon = PassengerWagons.new(wagon_number, all_seats)
        @wagons << wagon
        puts "Создан вагон " + wagon.number.to_s
      elsif wagon_type == 2
        puts "Введите общий объем вагона"
        all_volume = gets.chomp.to_i
        wagon = CargoWagons.new(wagon_number, all_volume)
        @wagons << wagon
        puts "Создан вагон " + wagon.number.to_s
      else
        puts "Неверный тип вагона"
      end
    rescue => e
      affempf = affempf + 1
      puts e.message
      retry if affempf < 3
    end
  end
end

def create_route
  puts "Перед вами список всех доступных станций:"
  show_all_station
  attempf = 0
  begin
    puts "Введите индекс начальной станции маршрута"
    index_begin = gets.chomp.to_i
    begin_selection_error = type_check(stations, index_begin)
    if begin_selection_error
      return
    end
    puts "Введите индекс конечной станции маршрута"
    index_end = gets.chomp.to_i
    end_selection_error = type_check(stations, index_end)
    if end_selection_error
      return
    end
    route = Route.new(stations[index_begin], stations[index_end])
    @routes << route
    puts "Создан маршрут! Его станции: "
    route.show_all
  rescue => e
    attempf = attempf + 1
    puts e.message
    retry if attempf < 3
  end
end

def add_stations_to_route
  puts "Какое изменение требуется? 1 - добавить станцию, 2 - удалить станцию"
  number = gets.chomp.to_i
  puts "Перед вами список всех доступных маршрутов:"
  show_all_route
  puts "Введите индекс выбранного маршрута:"
  index_route = gets.chomp.to_i
  route_selection_error = type_check(routes, index_route)
  if route_selection_error
    return
  end
  puts "Перед вами список всех доступных станций:"
  show_all_station
  puts "Введите индекс выбранной станции"
  index_station = gets.chomp.to_i
  station_selection_error = type_check(stations, index_station)
  if station_selection_error
    return
  end
  if number == 1
    routes[index_route].add(stations[index_station])
  elsif number == 2
    routes[index_route].delete(stations[index_station])
  end
  puts "Станции маршрута после изменения:"
  routes[index_route].show_all
end

def assign_route
  puts "Перед вами список всех доступных поездов:"
  show_all_train
  puts "Введите индекс выбранного поезда:"
  index_train = gets.chomp.to_i
  train_selection_error = type_check(trains, index_train)
  if train_selection_error
    return
  end
  puts "Перед вами список всех доступных маршрутов:"
  show_all_route
  puts "Введите индекс выбранного маршрута:"
  index_route = gets.chomp.to_i
  route_selection_error = type_check(routes, index_route)
  if route_selection_error
    return
  end
  trains[index_train].attach_route(routes[index_route])
  puts "Поезду #{trains[index_train].name}, пассажирский: #{trains[index_train].to_s},"
  puts "назначен маршрут #{routes[index_route]}"
end

def change_wagons
  puts "Какое изменение требуется? 1 - добавить вагон, 2 - удалить вагон"
  number = gets.chomp.to_i
  puts "Перед вами список всех доступных поездов:"
  show_all_train
  puts "Введите индекс выбранного поезда:"
  index_train = gets.chomp.to_i
  train_selection_error = type_check(trains, index_train)
  if train_selection_error
    return
  end
  puts "Перед вами список всех доступных вагонов:"
  show_all_wagons
  puts "Введите индекс выбранного вагона"
  index_wagons = gets.chomp.to_i
  wagons_selection_error = type_check(wagons, index_wagons)
  if wagons_selection_error
    return
  end
  if number == 1
    trains[index_train].attach_wagons(wagons[index_wagons])
  elsif number == 2
    trains[index_train].unhook_wagons(wagons[index_wagons])
  end
end

def occupy_seat_and_volume_wagons
  puts "Перед вами список всех доступных вагонов:"
  show_all_wagons
  puts "Введите индекс выбранного вагона"
  index_wagons = gets.chomp.to_i
  wagons_selection_error = type_check(wagons, index_wagons)
  if wagons_selection_error
    return
  end
  wagon = wagons[index_wagons]
  if wagon.passenger == true
    puts "Выбран пассажирский вагон под номером #{wagon.number}, ИНДЕКС #{index_wagons}"
    puts "Общее количество мест в нем #{wagon.all_seats}, из них свободно #{wagon.show_available}"
    puts "Нажмите 1 - занять место; 2 - освободить место"
    number_change = gets.chomp.to_i
    case number_change
    when 1
      wagon.alter_seat_busy
    when 2
      wagon.alter_seat_available
    end
    puts "Действие завершено. Теперь свободных пассажирских мест #{wagon.show_available}, из общего количества занято #{wagon.show_busy}"
  else
    puts "Выбран грузовой вагон под номером #{wagon.number}, ИНДЕКС #{index_wagons}"
    puts "Общий объем в нем #{wagon.all_volume}, доступный объем #{wagon.show_available}"
    puts "Нажмите 1 - занять объем; 2 - освободить объем"
    number_change = gets.chomp.to_i
    case number_change
    when 1
      puts "Введите, какое количество объема необходимо занять"
      value = gets.chomp.to_i
      wagon.alter_volume_busy(value)
    when 2
      puts "Введите, какое количество объема необходимо освободить"
      value = gets.chomp.to_i
      wagon.alter_volume_available(value)
    end
    puts "Действие завершено. Теперь доступный объем #{wagon.show_available}, из общего количества занято #{wagon.show_busy}"
  end
end

def print_wagons_list
  puts "Перед вами список всех доступных поездов:"
  show_all_train
  puts "Введите индекс выбранного поезда:"
  index_train = gets.chomp.to_i
  train_selection_error = type_check(trains, index_train)
  if train_selection_error
    return
  end
  trains[index_train].print_wagons_list
end

def print_trains_list
  puts "Перед вами список всех доступных станций:"
  show_all_station
  puts "Введите индекс выбранной станции"
  index_station = gets.chomp.to_i
  station_selection_error = type_check(stations, index_station)
  if station_selection_error
    return
  end
  stations[index_station].print_trains_list
end

def move_train
  puts "Какое перемещение поезда требуется? 1 - вперед, 2 - назад"
  number = gets.chomp.to_i
  puts "Перед вами список всех доступных поездов:"
  show_all_train
  puts "Введите индекс выбранного поезда:"
  index_train = gets.chomp.to_i
  train_selection_error = type_check(trains, index_train)
  if train_selection_error
    return
  end
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
    puts "Поезд #{train.name}, пассажирский: #{train.passenger.to_s}, ИНДЕКС #{index}"
  end
end

def show_all_wagons
  wagons.each_with_index do |wagon, index|
    puts "Вагон #{wagon.number}, пассажирский: #{wagon.passenger.to_s}, ИНДЕКС #{index}"
  end
end

def show_all_route
  routes.each_with_index do |route, index|
    puts "Маршрут, ИНДЕКС #{index}"
  end
end

def type_check(array, index)
  element = array[index]
  error = element.nil?
  if error
    puts "Ошибка в выборе элемента! Выполняется возврат в предыдущее меню..."
  end
  error
end
