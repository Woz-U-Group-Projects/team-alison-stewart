FactoryGirl.define do
  factory :service do
    sequence(:title) { |n| "title-#{n}" }
    contact_emails 'test@test.com'
  end
end
