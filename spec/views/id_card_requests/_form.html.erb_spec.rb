require 'rails_helper'

describe 'id_card_requests/_form.html.erb' do
  before(:each) do
    @school = FactoryGirl.create(:school)
    @id_card_template = FactoryGirl.create(:id_card_template, school: @school)
    @id_card_request = FactoryGirl.create(:id_card_request, id_card_template: @id_card_template, school: @school)
  end

  it 'should render' do
    expect{ render partial: 'id_card_requests/form', locals: { id_card_request: @id_card_request, id_card_template: @id_card_request.id_card_template } }.not_to raise_error
  end
end
