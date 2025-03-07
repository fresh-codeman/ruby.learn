require 'models_loader'

module DriverController

  def self.add_driver(params)
    x_coordinate, y_coordinate, driver_id = params.values_at(:x_coordinate, :y_coordinate, :driver_id)
    location = Location.new({x_coordinate:, y_coordinate:})
    driver_attrs = {location: location, id: driver_id}
    driver = Driver.new(driver_attrs)
    driver.save
  end
end