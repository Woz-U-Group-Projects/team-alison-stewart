require 'rails_helper'

describe 'electronic_marketings/_list_item.html.erb' do
  before(:each) do
    @electronic_marketing = FactoryGirl.create(:electronic_marketing)
    @important_date = FactoryGirl.create(:important_date)
  end

  it 'should render' do
    expect{ render partial: 'electronic_marketings/list_item', locals: { electronic_marketing: @electronic_marketing, important_date: @important_date } }.not_to raise_error
  end
end
