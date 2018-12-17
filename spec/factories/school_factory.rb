FactoryGirl.define do
  factory :school do
    sequence(:name) { |n| "school-#{n}" }
    sequence(:code) { |n| "code#{n}" }
  end
end
