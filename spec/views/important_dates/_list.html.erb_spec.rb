require 'rails_helper'

describe 'important_dates/_list.html.erb' do
  before(:each) do
    @important_dates = [FactoryGirl.create(:important_date)]
  end

  it 'should render' do
    expect{ render partial: 'important_dates/list', locals: { important_dates: @important_dates } }.not_to raise_error
  end
end
