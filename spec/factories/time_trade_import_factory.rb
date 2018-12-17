FactoryGirl.define do
  factory :time_trade_import do
    file File.open(Rails.root.join('spec', 'fixtures', 'time_trade', 'import.csv'))
  end
end
