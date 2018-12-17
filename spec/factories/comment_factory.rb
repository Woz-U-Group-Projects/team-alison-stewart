FactoryGirl.define do
  factory :comment do
    user
    owner factory: :school

    text 'Test comment'
  end
end
