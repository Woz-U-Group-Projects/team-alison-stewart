FactoryGirl.define do
  factory :booking do
    address
    customer

    sequence(:first_name) { |n| "first_name-#{n}" }
    sequence(:last_name) { |n| "last_name-#{n}" }
    sequence(:email_student) { |n| "email_student-#{n}@test.com" }
    phone_student '1235551234'
    phone_parent '1235551234'
    height_ft 5
    height_in 9
  end
end
