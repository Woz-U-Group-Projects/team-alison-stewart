FactoryGirl.define do
  factory :job_posting do
    job_type

    sequence(:name) { |n| "name-#{n}" }
    sequence(:title) { |n| "title-#{n}" }
  end
end
