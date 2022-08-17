class Route

  attr_reader :first

  attr_reader :last

  attr_reader :intermediate

  def initialize (first, last)
    @first        = first
    @last         = last
    @intermediate = []
  end

  def add (station)
    @intermediate << station
  end

  def delete (station)
    @intermediate.delete(station)
  end

  def show_all ()
    puts self.first
    puts self.intermediate
    puts self.last
  end

end