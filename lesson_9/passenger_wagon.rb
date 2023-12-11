# frozen_string_literal: true

class PassengerWagon < Wagon
  def initialize(total_place)
    @type = :passenger
    super
  end

  def take_place
    raise 'Недостаточно свободных мест в вагоне для совершения операции' unless free_place >= 1

    @used_place += 1
  end

  def give_place
    raise 'Недостаточно занятых в вагоне для совершения операции' unless used_place >= 1

    @used_place -= 1
  end
end
