require 'model/ride'

FactoryBot.define do
  factory :ride do
    id {Faker::Internet.uuid}
    status {RideStatus::ACCEPTED}

    initialize_with { new({id:, status:}) }
  end
end

def create_ongoing_ride(rider = nil, driver = nil)
  ride = build(:ride)
  driver = driver || build(:driver)
  rider = rider || build(:rider)
  driver.start_driving
  rider.start_riding
  ride.start_ride(driver, rider)
  ride.save
  driver.save
  rider.save
  ride
end

def create_completed_ride(ongoing_ride = nil, location = nil, time_taken = nil)
  ride = ongoing_ride || build_ongoing_ride
  location = location || build(:location)
  time_taken = time_taken || Faker::Number.number
  ride.stop_ride(location, time_taken)
  ride.rider.save 
  ride.driver.save 
  ride.save
  ride
end

def build_ongoing_ride(rider = nil, driver = nil)
  ride = build(:ride)
  driver = driver || build(:driver)
  rider = rider || build(:rider)
  driver.start_driving
  rider.start_riding
  ride.start_ride(driver, rider)
  ride
end

def build_completed_ride(ongoing_ride = nil, location = nil, time_taken = nil)
  ride = ongoing_ride || build_ongoing_ride
  location = location || build(:location)
  time_taken = time_taken || Faker::Number.number
  ride.stop_ride(location, time_taken)
  ride
end