FactoryGirl.define do
  factory :time_trade_appointment_type do
    time_trade_meta_data

    sequence(:type_id) { |n| "type_id-#{n}" }
    sequence(:photo_type) { |n| "photo_type-#{n}" }
    sequence(:resource_id) { |n| "resource_id-#{n}" }
  end
end
