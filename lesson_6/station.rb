require_relative 'instance_counter'

class Station
  include InstanceCounter

  attr_accessor :train_array
  attr_reader :name

  NAME_FORMAT = /^[a-zа-я\d\s]{1,20}$/i

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @train_array = []
    @@stations << self
    validate!
  end

  def show_trains
    self.train_array
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

  def validate!
    puts NAME_FORMAT
    puts @name
    puts self.name
    raise "Input error. To create a title, use only letters, numbers and spaces; the length of the title should not exceed 20 characters" if @name !~ NAME_FORMAT
  end
end
