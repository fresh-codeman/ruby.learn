# spec/factories/locations.rb
require "model/location"
FactoryBot.define do
  factory :location do
    x_coordinate {Faker::Number.between(from: 1, to: 100)}
    y_coordinate {Faker::Number.between(from: 1, to: 100)}
    initialize_with { new({x_coordinate: x_coordinate, y_coordinate: y_coordinate}) }
  
    trait :location_20_20 do
      x_coordinate {20}
      y_coordinate {20}
    end

    trait :location_3_2 do
      x_coordinate {3}
      y_coordinate {2}
    end

    trait :origin do
      x_coordinate {0}
      y_coordinate {0}
    end
  end
end