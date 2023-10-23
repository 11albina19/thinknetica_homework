# frozen_string_literal: true

class PassengerTrain < Train
  def initialize(name)
    @type = :passenger
    super
  end
end
