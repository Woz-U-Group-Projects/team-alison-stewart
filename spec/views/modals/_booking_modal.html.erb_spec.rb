require 'rails_helper'

describe 'modals/_booking_modal.html.erb' do
  before(:each) do
    @school = FactoryGirl.create(:school, code: 'TEST')
    @sitting = FactoryGirl.create(:sitting)
  end

  it 'should render' do
    expect{ render partial: 'modals/booking_modal', locals: { sitting: @sitting } }.not_to raise_error
  end
end
