# frozen_string_literal: true

class CargoTrain < Train
  def initialize(name)
    @type = :cargo
    super
  end
end
