require 'db/database'
require 'configs/price_config'
module RideStatus
  ACCEPTED = :accepted
  ONGOING = :ongoing
  COMPLETED = :completed
end

class Ride
  include Database 
  include PriceConfig 

  attr_reader :id, :status, :driver, :rider, :amount
  def initialize(attrs)
    @id = attrs[:id]
    @driver = nil
    @rider = nil
    @driver_source_location = nil
    @rider_source_location = nil
    @destination_location  = nil
    @time_taken = nil
    @amount = nil
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
    self.amount = self.calculate_amount
  end

  def ongoing?
    self.status == RideStatus::ONGOING
  end

  def completed?
    self.status == RideStatus::COMPLETED
  end

  private 
  attr_writer :driver, :rider, :status, :amount
  attr_accessor  :destination_location, :time_taken, :driver_source_location, :rider_source_location
  
  def calculate_amount
    amount_without_tax = calculate_amount_without_tax
    amount_without_tax + service_tax(amount_without_tax)
  end

  def calculate_amount_without_tax
    self.base_charge + self.distance_charge + self.time_charge
  end

  def base_charge
    FARE_CONFIG[:base_fare]
  end

  def distance_charge
    FARE_CONFIG[:per_km_charge] * self.rider_distance
  end

  def time_charge
    FARE_CONFIG[:per_min_charge] * self.time_taken
  end

  def service_tax(amount)
    (FARE_CONFIG[:service_tax_percentage] * amount)/100.0
  end

  def rider_distance
    self.rider_source_location.distance(self.destination_location)
  end
end