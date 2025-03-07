require 'db/database'

module RideStatus
  ACCEPTED = :accepted
  ONGOING = :ongoing
  COMPLETED = :completed
end

class Ride
  include Database  
  attr_reader :id, :status, :driver, :rider, :destination_location, :time_taken
  def initialize(id)
    @id = id
    @driver = nil
    @rider = nil
    @driver_source_location = nil
    @rider_source_location = nil
    @destination_location  = nil
    @time_taken = nil
    @status = RideStatus::ACCEPTED
  end

  def start_ride(driver, rider)
    self.driver = driver
    self.rider = rider
    self.driver_source_location = driver.location
    self.rider_source_location = rider.location
    self.status = RideStatus::ONGOING
  end

  def stop_ride(location, time_taken)
    self.destination_location = location
    self.time_taken = time_taken
    self.status = RideStatus::COMPLETED
  end

  def ongoing?
    self.status == RideStatus::ONGOING
  end

  def completed?
    self.status == RideStatus::COMPLETED
  end

  private 
  attr_writer :driver, :rider, :driver_source_location, :rider_source_location, :status, :destination_location, :time_taken
end