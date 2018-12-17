FactoryGirl.define do
  factory :electronic_marketing do
    school
    program_slug Program::SCHOOL_PHOTO_SLUG
    sequence(:name) { |n| "name-#{n}" }
    file File.open(Rails.root.join('spec', 'fixtures', 'xml', 'customer.xml'))
  end
end
