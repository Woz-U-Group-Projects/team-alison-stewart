require 'rails_helper'

describe 'id_card_requests/edit.html.erb' do
  before(:each) do
    @school = FactoryGirl.create(:school)
    @id_card_template = FactoryGirl.create(:id_card_template, school: @school)
    @id_card_request = FactoryGirl.create(:id_card_request, school: @school)
  end

  it 'should render' do
    expect{ render }.not_to raise_error
  end
end
