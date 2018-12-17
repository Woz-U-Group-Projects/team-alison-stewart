FactoryGirl.define do
  factory :event_type do
    sequence(:name) { |n| "name-#{n}" }
    highrise_field '03 Grad Sessions'
    sequence(:code) { |n| "code-#{n}" }
    program_slug Program::SCHOOL_PHOTO_SLUG
  end
end
