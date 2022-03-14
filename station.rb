require_relative 'instance_counter'
require_relative 'validate'

class Station
  include InstanceCounter
  include Validate
  attr_reader :name, :trains_list

  @@stations_list = []

  NAME_STATION = /^[а-яА-Я]+$/

  class << self            
    def add_station_list(station)
      @@stations_list.push(station)
    end

    def all
      @@stations_list
    end

    protected
    attr_accessor :stations_list
  end

  def initialize(name)
    @name = name
    @trains_list = []
    register_instance
    raise "Объект не создан. Неверные данные." unless valid?
  end

  def add_train(train)
    @train_list.push(train)
  end

  def send_train(train) 
    @trains_list.delete(train) if @trains_list.include? train
  end

  def show_trains_on_station_by_type(type)
    @trains_list.select { |train| train.type == type }
  end

  def passage_on_trains(&block)
    @trains_list.each { |train| block.call(train) }
  end

  protected

  def validate!
    raise "Название станции отсутствует!" if name.nil?
    raise "Невалидные данные названия станции!" if name !~ NAME_STATION
  end

end
