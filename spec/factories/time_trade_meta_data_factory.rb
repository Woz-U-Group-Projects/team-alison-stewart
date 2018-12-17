FactoryGirl.define do
  factory :time_trade_meta_data do
    school

    sequence(:school_code) { |n| "code#{n}" }
    sequence(:campaign_id) { |n| "campaign_id-#{n}" }
    sequence(:company_name) { |n| "company_name-#{n}" }
  end
end
