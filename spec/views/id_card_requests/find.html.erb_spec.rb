require 'rails_helper'

describe 'id_card_requests/find.html.erb' do
  before(:each) do
    @id_card_template = FactoryGirl.create(:id_card_template)
    @id_card_templates = [@id_card_template]
  end

  it 'should render' do
    expect{ render }.not_to raise_error
  end
end
