require 'model/driver'

FactoryBot.define do
  factory :driver do
    location { build(:location) }
    id {Faker::Internet.uuid}

    initialize_with{ new({location:, id: ,}) }
    trait :driver_at_origin do
      location {build(:location, :origin)}
    end

    trait :driver_at_20_20 do
      location {build(:location, :location_20_20)}
    end
    
    trait :driver_at_3_2 do
      location {build(:location, :location_3_2)}
    end
  end
end