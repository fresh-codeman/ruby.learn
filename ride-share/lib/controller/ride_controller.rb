require 'models_loader'

module RideController
  def self.start_ride(params)
    id, selected_driver_index, rider_id = params.values_at(:ride_id, :selected_driver_index, :rider_id)
    rider = Rider.get(rider_id)
    raise ArgumentError.new("Rider not exists for rider_id: #{rider_id}") if rider.nil?
    selected_driver = selected_driver(rider, selected_driver_index)
    raise NoDriverAvailable.new("#{selected_driver_index}th driver do not exist") unless selected_driver
    self.create_ride!(id, selected_driver, rider)
    self.update_driver!(selected_driver)
    self.update_rider!(rider)
  end

  
  def self.stop_ride(params)
    
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