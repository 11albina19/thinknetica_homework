# frozen_string_literal: true

class CargoWagon < Wagon
  def initialize(total_place)
    @type = :cargo
    super
  end

  def take_place(volume)
    raise 'Недостаточно свободного объема в вагоне для совершения операции' unless free_place >= volume

    @used_place += volume
  end

  def give_place(volume)
    raise 'Недостаточно занятого объема в вагоне для совершения операции' unless used_place >= volume

    @used_place -= volume
  end
end
