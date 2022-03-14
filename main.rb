require_relative 'route'
require_relative 'station'
require_relative 'cargo_train'
require_relative 'cargo_wagon'
require_relative 'passenger_train'
require_relative 'passenger_wagon'
require_relative 'interface'

railway_managment = Interface.new
railway_managment.action_menu
