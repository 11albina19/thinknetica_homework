class Station
  attr_reader :train_array, :name

  def initialize(name)
    @name        = name
    @train_array = []
  end
  
  def to_accept_train(train)
    puts('На станцию  ' + self.name + ' прибыл поезд ' + train.room.to_s)
    @train_array << train
  end

  def show_trains 
    puts self.train_array
  end

  def show_trains_type 

    quantity_p = 0
    quantity_c = 0
    for index in @train_array
      if index.passenger 
        quantity_p += 1
      else
        quantity_c += 1
      end
    end 
    puts('Количество пассажирских: ' + quantity_p.to_s + " , количество грузовых: " + quantity_c.to_s)
  end

  def send_train(train)
    puts('Со станции ' + self.name + ' отправляется поезд: ' + train.room.to_s)
    #@train_array - [train]
    @train_array.delete(train)
  end

end
