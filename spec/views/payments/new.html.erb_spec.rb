require 'rails_helper'

describe 'payments/new.html.erb' do
  before(:each) do
    @school = FactoryGirl.create(:school, code: 'TEST')
    @customer = FactoryGirl.create(:customer, id: "#{@school.code}16-123")
    @booking = FactoryGirl.create(:booking, customer: @customer)
    @payment = FactoryGirl.build(:payment, booking: @booking)
  end

  it 'should render' do
    expect{ render }.not_to raise_error
  end
end
