class PassengerWagon < Wagon
  def initialize(total_place)
    @type = :passenger
    super
  end

  def take_place
    if free_place >= 1
      @used_place += 1
    else
      raise "Недостаточно свободных мест в вагоне для совершения операции"
    end
  end

  def give_place
    if self.used_place >= 1
      @used_place -= 1
    else
      raise "Недостаточно занятых в вагоне для совершения операции"
    end
  end
end
