require 'rails_helper'

describe 'contact_request_mailer/request_email.text.erb' do
  before(:each) do
    @contact_request = FactoryGirl.create(:contact_request)
  end

  it 'should render' do
    expect{ render }.not_to raise_error
  end
end
