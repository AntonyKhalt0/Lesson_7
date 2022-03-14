require_relative 'train'
require_relative 'instance_counter'

class PassengerTrain < Train
  attr_reader :type

  def initialize
    super
    @type = 'Passenger'
  end

end
