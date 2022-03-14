class Interface
  def initialize
    @stations = [] 
    @trains_list = []
    @routes = []
  end

  def action_menu
    loop do
      puts "Введите 1, чтобы создать станцию.\n
            Введите 2, чтобы создать поезд.\n
            Введите 3, чтобы создать маршрут и управлять станциями в нем.\n
            Введите 4, чтобы назначить маршрут поезду.\n
            Введите 5, чтобы управлять вагонами поезда.\n
            Введите 6, чтобы перемещать поезд по маршруту.\n
            Введите 7, чтобы просматривать список станций и список поездов на станции.
            Введите 8, чтобы выйти из программы. "
      choice = gets.chomp.to_i
      case choice
      when 1
        create_station        
      when 2
        create_train
      when 3
        route_managment
      when 4
        assign_route_to_train  
      when 5
        wagons_managment
      when 6
        move_the_train  
      when 7
        show_trains_on_stations
      when 8
        puts "До свидания!"
        break
      end
    end
  end

  private

  def create_station
    puts "Введите название станции: "
    station_name = gets.chomp
    station_name.capitalize!
    station = Station.new(station_name)
    puts "Станция создана!"  
    @stations.push(station)
    #Station.add_stations_list(station)
  end

  def create_train
    puts "Введите номер поезда: "
    train_number = gets.chomp.to_i
    puts "Введите 1, чтобы создать пассажирский поезд.\n
          Введите 2 чтобы создать грузовой поезд. "
    choice_type_train = gets.chomp.to_i
    case choice_type_train
    when 1
      train = create_passenger_train(train_number)
      puts "Пассажирский поезд создан!"
      #PassengerTrain.add_trains_list(train)
    when 2
      train = create_cargo_train(train_number)
      puts "Грузовой поезд создан!"
      #CargoTrain.add_trains_list(train)
    end
  end

  def create_passenger_train(train_number)
    @trains_list.push(PassengerTrain.new(train_number))
  end

  def create_cargo_train(train_number)
    @trains_list.push(CargoTrain.new(train_number))
  end

  def route_managment
    puts "Введите 1, чтобы создать маршрут.\n
          Введите 2, чтобы просмотреть список станций маршрута.\n
          Введите 3, чтобы добавить станцию.\n
          Введите 4, чтобы удалить станцию."
    choice_route = gets.chomp.to_i
    case choice_route
    when 1
      create_route
    when 2
      show_route_stations
    when 3
      add_station_in_route
    when 4
      delete_station_in_route
    end
  end

  def create_route
    @stations.each_with_index { |station, index| puts "#{i.next} - #{station.name}" }
    puts "Введите номер первой и последней станции: "
    station_first = gets.chomp.to_i
    station_last = gets.chomp.to_i
    @routes.push(Route.new(route_name(@stations[station_first.pred], @stations[station_last.pred]), 
                          @stations[station_first.pred], @stations[station_last.pred]))
    puts "Маршрут создан!"
  end

  def show_route_stations
    route_number = route_selection(@routes)
    @routes[route_number.pred].show_stations
  end

  def add_station_in_route
    route_number = route_selection(@routes)
    @routes[route_number.pred].show_stations
    puts "Введите номер станции, после которой добавить новую: "
    pred_station_number = gets.chomp.to_i
    puts "Список доступных станций: "
    @stations.each_with_index { |station, index| puts "Станция - #{station.name}" unless @stations.include? station }
    puts "Выберите станцию: "
    station_name = gets.chomp
    station_name.capitalize!
    @routes[route_number.pred].add_station(pred_station_number, @stations[@stations.index(station_name)])
  end

  def delete_station_in_route
    route_number = route_selection(@routes)
    @routes[route_number.pred].show_stations
    puts "Выберите станцию, которую хотите удалить из маршрута: "
    station_name = gets.chomp
    station_name.capitalize!
    @routes[route_number.pred].delete_station(@stations[@stations.index(station_name)])
  end

  def assign_route_to_train
    current_train = train(@trains_list)
    route_number = route_selection(@routes)
    current_train.train_route(@routes[route_number.pred])
    @routes[route_number.pred].stations.first.add_train(current_train)
  end

  def wagons_managment
    current_train = train(@trains_list)
    puts "Введите 1, чтобы просмотреть вагоны поезда.\n
          Введите 2, чтобы заполнить вагон поезда.\n
          Введите 3, чтобы добавить вагон.\n
          Введите 4, чтобы отцепить вагон."
    select_action_with_wagon = gets.chomp.to_i
    case select_action_with_wagon
    when 1
      current_train.passage_on_wagons(railcar_output_block) 
    when 2
      filling_wagon(current_train)
    when 3
      attach_wagon(current_train)
    when 4
      unpin_wagon(current_train)
    end
  end

  def attach_wagon(current_train)
    if current_train.type == 'Cargo'
      puts "Введите объем вагона: "
      volume = gets.chomp.to_i
      wagon = CargoWagon.new(volume)
    elsif current_train.type == 'Passenger'
      puts "Введите количество мест вагона: "
      places = gets.chomp.to_i
      wagon = PassengerWagon.new(places)
    end
    current_train.attach_wagons(wagon)
  end

  def unpin_wagon(current_train)
    puts "Количеcтво вагонов поезда: #{current_train.wagons.length}\n
          Введите номер удаляемого вагона: "
    wagon_index = gets.chomp.to_i
    current_train.unpin_wagons(wagon_index)
  end

  def filling_wagon(current_train)
    puts "Количеcтво вагонов поезда: #{current_train.wagons.length}\n
          Введите номер вагона: "
    wagon_index = gets.chomp.to_i
    if current_train.type == 'Cargo'
      puts "Введите объем груза: "
      cargo_volume = gets.chomp.to_i
      current_train_wagon(current_train, wagon_index).filling_in_volume
    elsif current_train.type == 'Passenger'
      current_train_wagon(current_train, wagon_index).filling_places
    end
  end

  def move_the_train 
    current_train = train(@trains_list)
    puts "Введите 1, чтобы переместить поезд вперед на одну станцию.\n
          Введите 2, чтобы переместить поезд назад на одну станцию."
    moving = gets.chomp
    case moving
    when 1
      move_forward(current_train)
    when 2
      move_back(current_train)
    end
  end

  def move_forward(current_train)
    if current_train.moving_forward 
      current_train.previous_station.send_train(current_train)
      add_train_on_station(current_train)
    end
  end

  def move_back(current_train)
    if current_train.moving_back
      current_train.next_station.send_train(current_train)
      add_train_on_station(current_train)
    end
  end

  def show_trains_on_stations
    @stations.each_with_index do |station, index|
      puts "Станция - #{station.name}. Поезда на станции: "
      station.passage_on_trains { puts "Номер: #{train.number}, тип: #{train.type},\
                                  вагоны: #{train.passage_on_wagons(railcar_output_block)}" }
    end
  end

  def route_name(station_first, station_last)
    "#{station_first.name}-#{station_last.name}"
  end

  def route_selection(routes)
    routes.each_with_index { |route, i| puts "#{i.next} - #{route.name}" }
    puts "Введите номер маршрута"
    gets.chomp.to_i
  end

  def train(trains_list)
    puts "Введите номер поезда: "
    train_number = gets.chomp.to_i
    trains_list[trains_list.index(train_number)]
  end

  def add_train_on_station(current_train)
    current_train.current_station.add_train(current_train)
  end

  def wagon_of(current_train)
    PassengerWagon.new if current_train.type == "Passenger"
    CargoWagon.new if current_train.type == "Cargo"
  end

  def railcar_output_block
    { puts "Вагон: #{wagon.type}, свободно: #{wagon.available_value}, занято: #{wagon.occupied_value}" }
  end

  def current_train_wagon(current_train, wagon_index)
    current_train.wagons[wagon_index.pred]
  end 
end
