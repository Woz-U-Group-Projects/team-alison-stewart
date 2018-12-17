FactoryGirl.define do
  factory :product do
    sequence(:name) { |n| "name-#{n}" }
    sequence(:description) { |n| "description-#{n}" }
    platform 'junior'
  end
end
