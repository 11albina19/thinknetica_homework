require_relative 'instance_counter'

class Station
  include InstanceCounter

  attr_accessor :train_array
  attr_reader   :name

  @@stations = []

  def self.all ()
    puts @@stations
  end

  def initialize(name)
    @name        = name
    @train_array = []
    @@stations << self
  end

  def show_trains 
    puts self.train_array
  end

  def show_trains_type 
    quantity_p = 0
    quantity_c = 0
    for index in self.train_array
      if index.passenger 
        quantity_p += 1
      else
        quantity_c += 1
      end
    end 
    puts('Количество пассажирских: ' + quantity_p.to_s + " , количество грузовых: " + quantity_c.to_s)
  end

  def to_accept_train(train)
    puts('На станцию  ' + self.name + ' прибыл поезд ' + train.room.to_s)
    self.train_array << train
  end

  def send_train(train)
    puts('Со станции ' + self.name + ' отправляется поезд: ' + train.room.to_s)
    self.train_array.delete(train)
  end

end
