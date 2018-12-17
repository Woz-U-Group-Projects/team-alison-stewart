FactoryGirl.define do
  factory :feature do
    owner factory: :sitting

    sequence(:description) { |n| "description-#{n}" }
  end
end
