FactoryGirl.define do
  factory :program do
    sequence(:id) { |n| n }
    sequence(:name) { |n| "name-#{n}" }
    sequence(:slug) { Program::SCHOOL_PHOTO_SLUG }
  end
end
