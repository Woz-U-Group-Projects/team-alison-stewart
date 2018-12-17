FactoryGirl.define do
  factory :customer do
    sequence(:ID) { |n| "ID-#{n}" }
    name Customer::PLACEHOLDER_NAME
  end
end
