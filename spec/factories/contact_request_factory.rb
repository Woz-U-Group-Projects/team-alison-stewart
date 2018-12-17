FactoryGirl.define do
  factory :contact_request do
    to_emails 'to@test.com'
    from_email 'from@test.com'
    subject 'subject'
    body 'body'
  end
end
