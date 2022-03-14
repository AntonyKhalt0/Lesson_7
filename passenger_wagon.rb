require_relative 'wagon'

class PassengerWagon < Wagon
  def initialize
    super
    @type = 'Passenger'
  end
  
  def filling_places
    @available_value -= 1 if @available_value != 0
  end
  
end
