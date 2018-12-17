FactoryGirl.define do
  factory :important_date do
    important_date_type
    school

    sequence(:name) { |n| "name-#{n}" }
    sequence(:value) { |n| "value-#{n}" }
  end
end
