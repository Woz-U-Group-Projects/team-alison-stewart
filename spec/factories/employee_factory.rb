FactoryGirl.define do
  factory :employee do
    sequence(:first_name) { |n| "first-name-#{n}" }
    sequence(:last_name) { |n| "last-name-#{n}" }
    title 'Employee Title'
  end
end
