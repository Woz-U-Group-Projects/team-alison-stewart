FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "email-#{n}@test.com" }
    password 'password'
    password_confirmation 'password'
    enabled true
  end
end
