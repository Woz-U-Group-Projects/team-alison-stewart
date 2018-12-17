FactoryGirl.define do
  factory :frequently_asked_question do
    frequently_asked_question_type

    sequence(:question) { |n| "question-#{n}" }
    sequence(:answer) { |n| "answer-#{n}" }
  end
end
