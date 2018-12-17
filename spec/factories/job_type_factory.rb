FactoryGirl.define do
  factory :job_type do
    sequence(:name) { |n| "name-#{n}" }
  end
end
