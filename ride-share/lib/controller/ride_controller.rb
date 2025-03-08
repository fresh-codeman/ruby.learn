require 'model/location'
require 'model/driver'
require 'model/rider'
require 'model/ride'
require_relative '../errors/invalid_ride_error'

module RideController
  def self.start_ride(params)
    id, selected_driver_index, rider_id = params.values_at(:ride_id, :selected_driver_index, :rider_id)
    rider = Rider.get(rider_id)
    raise InvalidRideError.new("Rider not exists for rider_id: #{rider_id}") if rider.nil?
    selected_driver = selected_driver(rider, selected_driver_index)
    raise InvalidRideError.new("#{selected_driver_index}th driver do not exist") unless selected_driver
    self.create_ride!(id, selected_driver, rider)
    self.update_driver!(selected_driver)
    self.update_rider!(rider)
    {data: {ride_id: id}, error: nil}
  rescue => error
    {error: , data: nil}
  end

  def self.stop_ride(params)
    id, x_coordinate, y_coordinate, time_taken = params.values_at(:ride_id, :destination_x_coordinate, :destination_y_coordinate, :time_taken_in_min)
    ride = Ride.get(id){|_ride| _ride.status == RideStatus::ONGOING}
    raise InvalidRideError.new("Ride not exists/available for ride_id: #{id}") unless ride
    location = Location.new({x_coordinate:, y_coordinate:})
    ride.stop_ride(location, time_taken)
    ride.driver.stop_driving
    ride.driver.location = location
    ride.driver.save
    ride.rider.stop_riding
    ride.rider.location = location
    ride.rider.save
    {data: {ride_id: id}, error: nil}
  rescue => error
    {error: , data: nil}
  end
  
  private
  
  def self.create_ride!(id, selected_driver, rider)
    ride = Ride.new({id: })
    ride.start_ride(selected_driver,rider)
    ride.save
  end

  def self.update_driver!(driver)
        driver.start_driving
    driver.save
  end

  def self.update_rider!(rider)
    rider.start_riding
    rider.matches = nil
    rider.save
  end
  def self.selected_driver(rider, index)
    return false if rider.matches.to_a.empty?
    rider.matches[index-1]
  end
end