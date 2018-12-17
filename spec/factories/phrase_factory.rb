FactoryGirl.define do
  factory :phrase do
    node

    sequence(:name) { |n| "Name-#{n}" }
    text 'Test text'
  end
end
