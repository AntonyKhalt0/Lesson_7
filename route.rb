require_relative 'instance_counter'
require_relative 'validate'

class Route
  include InstanceCounter
  include Validate
  attr_reader :name, :stations

  def intialize(name, first_station, last_station)
    @name = name
    @stations = [first_station, last_station]
    register_instance
    raise "Объект не создан. Неверные данные." unless valid?
  end

  def add_station(previous_station, new_station)
    @stations.insert(@stations.index(previous_station) + 1, new_station)
  end

  def delete_station(selected_station)
    @stations.delete(selected_station)
  end

  def show_stations
    @stations.each_with_index { |station, index| "#{index.next} - станция: #{station.name}" }
  end

  protected

  def validate!
    raise "Название станции отсутствует!" if name.nil?
    raise "Начальная стания отсутствует!" if first_station.nil?
    raise "Конечная стания отсутствует!" if last_station.nil?
    raise "Неверные данные начальной станции!" if first_station.class != Station 
    raise "Неверные данные конечной станции!" if last_station.class != Station
  end

end
