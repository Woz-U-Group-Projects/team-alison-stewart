FactoryGirl.define do
  factory :important_date_type_program do
    important_date_type

    program_slug Program::SCHOOL_PHOTO_SLUG
  end
end
