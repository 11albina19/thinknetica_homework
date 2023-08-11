class CargoWagon < Wagon
  def initialize(total_place)
    @type = :cargo
    super
  end

  def take_place(volume)
    if free_place >= volume
      @used_place += volume
    else
      raise "Недостаточно свободного объема в вагоне для совершения операции"
    end
  end

  def give_place(volume)
    if self.used_place >= volume
      @used_place -= volume
    else
      raise "Недостаточно занятого объема в вагоне для совершения операции"
    end
  end
end
