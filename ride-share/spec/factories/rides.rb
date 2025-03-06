require_relative '../../model/ride'

FactoryBot.define do
  factory :ride do
    id {Faker::Internet.uuid}
    status {RideStatus::ACCEPTED}

    initialize_with { new({id:, status:}) }
  end
end
def create_ongoing_ride 
  ride = build(:ride)
  driver = build(:driver)
  rider = build(:rider)
  ride.start_ride(driver, rider)
  ride
end

def create_completed_ride
  ride = create_ongoing_ride
  location = build(:location)
  time_taken = Faker::Number.number
  ride.stop_ride(location, time_taken)
  ride
end