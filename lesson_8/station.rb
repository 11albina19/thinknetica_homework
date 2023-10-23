# frozen_string_literal: true

require_relative 'instance_counter'

class Station
  include InstanceCounter

  attr_accessor :train_array
  attr_reader :name

  NAME_FORMAT = /^[a-zа-я\d\s]{1,20}$/i.freeze

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
    train_array
  end

  def show_list_trains(&block)
    return until block_given?
    trains = show_trains
    trains.each(&block)
  end

  def print_trains_list
    block = ->(train) { puts "#{train.name}, #{train.type}, #{train.show_trains} " }
    show_list_trains(&block)
  end

  def show_trains_type
    quantity_p = 0
    quantity_c = 0
    train_array.each do |index|
      if index.passenger
        quantity_p += 1
      else
        quantity_c += 1
      end
    end
    puts("Количество пассажирских: #{quantity_p} , количество грузовых: #{quantity_c}")
  end

  def to_accept_train(train)
    puts("На станцию  #{name} прибыл поезд #{train.name}")
    train_array << train
  end

  def send_train(train)
    puts("Со станции #{name} отправляется поезд: #{train.name}")
    train_array.delete(train)
  end

  def validate!
    return unless @name !~ NAME_FORMAT

    raise 'Input Error. To create a title, use only letters, numbers and spaces; length no more than 20 characters'
  end
end
