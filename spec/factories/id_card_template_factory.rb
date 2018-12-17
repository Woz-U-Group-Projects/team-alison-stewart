FactoryGirl.define do
  factory :id_card_template do
    school

    sequence(:name) { |n| "name-#{n}" }
    base_photo File.open(Rails.root.join('spec', 'fixtures', 'images', 'buildings.jpg'))
  end
end
