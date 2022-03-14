require_relative 'manufactures_name'

class Wagon
  include ManufacturesName
  attr_reader :type, :available_value

  def initialize(total_value)
    @total_value = total_value
    @available_value = total_value
  end

  def occupied_value
    @total_value - @available_value
  end
end
