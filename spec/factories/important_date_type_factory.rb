FactoryGirl.define do
  factory :important_date_type do
    highrise_field '01 Photo Day'
    sequence(:code) { |n| "code-#{n}" }
    sequence(:name) { |n| "name-#{n}" }
  end
end
