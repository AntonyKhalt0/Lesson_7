require_relative 'train'
require_relative 'instance_counter'

class CargoTrain < Train
  attr_reader :type
  
  def initialize
    super
    @type = 'Cargo'
  end

end
