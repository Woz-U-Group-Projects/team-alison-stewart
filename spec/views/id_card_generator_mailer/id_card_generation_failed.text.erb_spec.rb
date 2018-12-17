require 'rails_helper'

describe 'id_card_generator_mailer/id_card_generation_failed.text.erb' do
  before(:each) do
    @id_card_request = FactoryGirl.create(:id_card_request)
    @message = 'message'
  end

  it 'should render' do
    expect{ render }.not_to raise_error
  end
end
