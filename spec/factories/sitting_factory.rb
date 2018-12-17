FactoryGirl.define do
  factory :sitting do
    event_type

    sequence(:name) { |n| "name-#{n}" }
    sequence(:duration) { |n| "duration-#{n}" }
  end
end
