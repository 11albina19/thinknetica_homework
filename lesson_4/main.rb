require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'station'
require_relative 'route'
require_relative 'passenger_wagons'
require_relative 'cargo_wagons'

#st1 = Station.new("Центральная")
#puts "Создана станция: #{st1.name}, #{st1}"

#st2 = Station.new("Покровская")
#puts "Создана станция: #{st2.name}, #{st2}"

#st3 = Station.new("Восстания")
#puts "Создана станция: #{st3.name}, #{st3}"

#st4 = Station.new("Северная")
#puts "Создана станция: #{st4.name}, #{st4}"

#st5 = Station.new("Восточная")
#puts "Создана станция: #{st5.name}, #{st5}"

#st6 = Station.new("Северо-восток")
#puts "Создана станция: #{st6.name}, #{st6}"

#pa1 = PassengerWagons.new(1)
#pa2 = PassengerWagons.new(2)
#t1  = PassengerTrain.new(1)
#puts "Создан поезд: #{t1.room}"
#puts "Все вагоны: #{t1.show_trains()}"
#t1.attach(pa1)
#t1.attach(pa2)
#puts "Все вагоны после добавления: #{t1.show_trains()}"

#t2 = Train.new(2, true, 6)
#puts "Создан поезд: #{t2.room}"

#t3 = Train.new(3, false, 15)
#puts "Создан поезд: #{t3.room}"

#r1 = Route.new(st1, st4)
#puts "Создан маршрут: #{r1}"
#r1.add(st2)
#r1.add(st3)
#r1.add(st3)
#r1.add(st5)
#r1.delete(st5)
#r1.show_all

#r2 = Route.new(st5, st1)
#puts "Создан маршрут: #{r2}"

#r3 = Route.new(st4, st5)
#puts "Создан маршрут: #{r3}"
