FactoryGirl.define do
  factory :feedback do
    from_email 'from@test.com'
    subject 'subject'
    body 'body'
  end
end
