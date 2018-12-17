FactoryGirl.define do
  factory :photo do
    owner factory: :school

    file_name File.open(Rails.root.join('spec', 'fixtures', 'images', 'buildings.jpg'))
  end
end
