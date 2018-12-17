require 'rails_helper'

describe 'id_card_request_mailer/new_request.html.erb' do
  before(:each) do
    @id_card_request = FactoryGirl.create(:id_card_request)
  end

  it 'should render' do
    expect{ render }.not_to raise_error
  end
end
