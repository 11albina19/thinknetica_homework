require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'station'
require_relative 'route'
require_relative 'passenger_wagons'
require_relative 'cargo_wagons'

class RailRoad
  attr_accessor :array_station, :array_train, :array_wagons, :array_route

  def initialize()
    @array_station = []
    @array_train   = []
    @array_wagons  = []
    @array_route   = []
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
      if number == 4 
        puts "Выполнение программы завершено."
        break  
      end
      if number == 1
        puts "-------------------------------------------------------------------"
        puts "Введите 0, если вы хотите создать станцию"
        puts "Введите 1, если вы хотите создать поезд"
        puts "Введите 2, если вы хотите создать вагон"
        puts "Введите 3, если вы хотите создать маршрут"
        number_greate = gets.chomp.to_i
        if number_greate == 0
          greate_station
        else
          if number_greate == 1 
            greate_train
          else
            if number_greate == 2 
              greate_wagons
            else
              if number_greate == 3
                greate_route
              else
                puts "Номер не определен. Выполнение программы завершено."
                break 
              end
            end
          end
        end
      else
        if number == 2
          puts "-------------------------------------------------------------------" 
          puts "Введите 0, если вы хотите добавить/удалить станции в существующий маршрут"
          puts "Введите 1, если вы хотите назначить маршрут поезду"
          puts "Введите 2, если вы хотите изменить состав вагонов у поезда"
          puts "Введите 3, если вы хотите переместить поезд по маршруту"
          number_change = gets.chomp.to_i
          if number_change == 0
          add_stations_to_route
        else
          if number_change == 1
          assign_route
        else
          if number_change == 2
          change_wagons
        else
          if number_change == 3
          move_train
        else
          puts "Номер не определен."
        end
      end
    end
  end
else
  if number == 3
    puts "-------------------------------------------------------------------"  
    puts "Созданные станции:" 
    show_all_station
    puts "Созданные маршруты:"
    show_all_route
    puts "Созданные поезда:" 
    show_all_train
    puts "Созданные вагоны:"
    show_all_wagons
  else
   puts "Номер не определен." 
 end
end
end
end
end

def greate_station
  puts "Как назвать станцию?"
  name = gets.chomp
  st = Station.new(name)
  self.array_station << st
  puts "Создана станция " + st.name + " !"
end

def greate_train
  puts "Это пассажирский поезд? 1 - пассажирский, 2 - грузовой"
  number_passenger = gets.chomp.to_i
  puts "Введите номер поезда"
  train_room = gets.chomp.to_i
  if number_passenger == 1
    t = PassengerTrain.new(train_room)
    self.array_train << t
    puts "Создан поезд " + t.room.to_s 
  else
    if number_passenger == 2
      t = CargoTrain.new(train_room)
      self.array_train << t
      puts "Создан поезд " + t.room.to_s  
    else
     puts "Номер не определен." 
   end 
 end
end
end

def greate_wagons 
  puts "Это пассажирский вагон? 1 - пассажирский, 2 - грузовой"
  number_passenger = gets.chomp.to_i
  puts "Введите номер вагона"
  wagons_room = gets.chomp.to_i
  if number_passenger == 1
    w = PassengerWagons.new(wagons_room)
    self.array_wagons << w
    puts "Создан вагон " + w.room.to_s 
  else
    if number_passenger == 2
      w = CargoWagons.new(wagons_room)
      self.array_wagons << w
      puts "Создан вагон " + w.room.to_s  
    else
     puts "Номер не определен." 
   end 
 end
end

def greate_route
  puts "Перед вами список всех доступных станций:"
  show_all_station
  puts "Введите индекс начальной станции маршрута"
  index_begin = gets.chomp.to_i
  puts "Введите индекс конечной станции маршрута"
  index_end = gets.chomp.to_i
  r = Route.new(array_station[index_begin], array_station[index_end])
  self.array_route << r 
  puts "Создан маршрут! Его станции: "
  r.show_all 
end

def add_stations_to_route
  #добавить станцию в маршрут
end

def assign_route
  #назначить маршрут поезду
end

def change_wagons
  #изменить состав вагонов у поезда
end

def move_train
  #переместить поезд по маршруту
end 

def show_all_station
  i = 0;
  for index in self.array_station
    puts "Станция #{index.name}, #{index}, ИНДЕКС #{i}" 
    i = i + 1
  end
end

def show_all_train
  i = 0;
  for index in self.array_train
    puts "Поезд #{index.room}, пассажирский: #{index.passenger.to_s}, #{index}, ИНДЕКС #{i}"
    i = i + 1; 
  end
end

def show_all_wagons
  i = 0;
  for index in self.array_wagons
    puts "Вагон #{index.room}, пассажирский: #{index.passenger.to_s}, #{index}, ИНДЕКС #{i}"
    i = i + 1; 
  end
end

def show_all_route
  i = 0;
  for index in self.array_route
    puts "Маршрут #{index}, ИНДЕКС #{i}"
    i = i + 1; 
  end
end
