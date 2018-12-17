require 'rails_helper'

describe 'sitting/_list_item.html.erb' do
  before(:each) do
    @school = FactoryGirl.create(:school)
    @sitting = FactoryGirl.create(:sitting)
  end

  it 'should render' do
    expect{ render partial: 'sittings/list_item', locals: { sitting: @sitting } }.not_to raise_error
  end
end
