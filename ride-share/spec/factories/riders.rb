require_relative '../../model/rider'

FactoryBot.define do
  factory :rider do
    location { build(:location) }
    id {Faker::Internet.uuid}

    initialize_with{ new({location:, id: ,}) }
    trait :rider_at_origin do
      location {build(:location, :origin)}
    end
  end
end