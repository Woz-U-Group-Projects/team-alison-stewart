FactoryGirl.define do
  factory :id_card_request do
    school
    id_card_template { FactoryGirl.create(:id_card_template, school: school) }

    sequence(:student_number) { |n| "student_number-#{n}" }
    attention_of 'Test'
    attention_of_email 'test@test.com'
  end
end
