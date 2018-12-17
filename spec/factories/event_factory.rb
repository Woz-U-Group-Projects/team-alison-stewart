FactoryGirl.define do
  factory :event do
    event_type
    school

    sequence(:date) { |n| "date-#{n}" }
  end
end
