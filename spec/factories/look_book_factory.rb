FactoryGirl.define do
  factory :look_book do
    service

    after(:create) do |look_book|
      FactoryGirl.create(:photo, owner: look_book)
    end
  end
end
