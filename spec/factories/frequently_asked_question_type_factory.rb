FactoryGirl.define do
  factory :frequently_asked_question_type do
    sequence(:name) { |n| "name-#{n}" }
  end
end
