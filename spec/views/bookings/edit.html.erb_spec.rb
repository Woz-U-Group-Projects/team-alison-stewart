require 'rails_helper'

describe 'bookings/edit.html.erb' do
  before(:each) do
    @school = FactoryGirl.create(:school, code: 'TEST')
    @customer = FactoryGirl.create(:customer, id: "#{@school.code}16-123")
    @booking = FactoryGirl.create(:booking, customer: @customer)
    @booking.address = FactoryGirl.build(:address)
  end

  it 'should render' do
    expect{ render }.not_to raise_error
  end
end
