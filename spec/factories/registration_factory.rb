FactoryGirl.define do
  factory :registration do
    school

    sequence(:first_name) { |n| "first_name-#{n}" }
    sequence(:middle_name) { |n| "middle_name-#{n}" }
    sequence(:last_name) { |n| "last_name-#{n}" }
    sequence(:student_number) { |n| "student_number-#{n}" }
    email_address 'test@test.com'
    sequence(:degree) { |n| "degree-#{n}" }
  end
end
