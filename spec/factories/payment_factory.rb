FactoryGirl.define do
  factory :payment do
    gateway_transaction
    booking

    amount Booking::DEPOSIT_AMOUNT
    payment_method 'visa'
    received_on Date.today
  end
end
