require 'rails_helper'

describe 'events/_list_item.html.erb' do
  before(:each) do
    @electronic_marketing = FactoryGirl.create(:electronic_marketing)
    @event = FactoryGirl.create(:event)
  end

  it 'should render' do
    expect{ render partial: 'events/list_item', locals: { electronic_marketing: @electronic_marketing, event: @event } }.not_to raise_error
  end
end
