FactoryGirl.define do
  factory :user_defined_field do
    sequence(:ROWID) { |n| "ROWID-#{n}" }
    sequence(:DOCUMENT_ID) { |n| "DOCUMENT_ID-#{n}" }
    sequence(:ID) { |n| "ID-#{n}" }
    sequence(:STRING_VAL) { |n| "STRING_VAL-#{n}" }
  end
end
