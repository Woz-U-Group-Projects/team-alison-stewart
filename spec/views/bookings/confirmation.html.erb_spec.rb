require 'rails_helper'

describe 'bookings/confirmation.html.erb' do
  before(:each) do
    @school = FactoryGirl.create(:school, code: 'TEST')
    @customer = FactoryGirl.create(:customer, id: "#{@school.code}16-123")
    @booking = FactoryGirl.create(:booking, customer: @customer)
    @payment = FactoryGirl.create(:payment, booking: @booking)
  end

  it 'should render without time trade' do
    expect{ render }.not_to raise_error
  end

  it 'should render with time trade' do
    @time_trade_meta_data = FactoryGirl.create(:time_trade_meta_data, school: @school)
    @time_trade_appointment_type = FactoryGirl.create(:time_trade_appointment_type, time_trade_meta_data: @time_trade_meta_data)

    expect{ render }.not_to raise_error
  end
end
