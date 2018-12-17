require 'rails_helper'

describe 'important_dates/_list_item.html.erb' do
  before(:each) do
    @important_date = FactoryGirl.create(:important_date)
  end

  it 'should render' do
    expect{ render partial: 'important_dates/list_item', locals: { important_date: @important_date } }.not_to raise_error
  end
end
