require 'rails_helper'

describe 'registrations/new.html.erb' do
  before(:each) do
    @school = FactoryGirl.create(:school)
    @registration = FactoryGirl.create(:registration)
    @registration.address = FactoryGirl.build(:address)
  end

  it 'should render' do
    expect{ render }.not_to raise_error
  end
end
