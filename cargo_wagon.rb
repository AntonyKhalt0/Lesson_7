require_relative 'wagon'

class CargoWagon < Wagon
  def initialize
    super
    @type = 'Cargo'
  end
  
  def filling_in_volume(cargo_quantity)
    @available_volume -= cargo_quantity if @available_volume - cargo_quantity >= 0
  end
  
end
