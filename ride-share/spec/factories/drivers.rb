require 'model/driver'

FactoryBot.define do
  factory :driver do
    location { build(:location) }
    id {Faker::Internet.uuid}

    initialize_with{ new({location:, id: ,}) }
    trait :driver_at_origin do
      location {build(:location, :origin)}
    end
  end
end