FactoryGirl.define do
  factory :address do
    owner factory: :school

    sequence(:address1) { |n| "address1-#{n}" }
    sequence(:city) { |n| "city-#{n}" }
    sequence(:province) { |n| "province-#{n}" }
    country 'Canada'
    postal_code 'V9A 4P7'
  end
end
