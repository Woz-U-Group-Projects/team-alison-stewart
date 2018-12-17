require 'rails_helper'

describe 'root/show.html.erb' do
  before(:each) do
    @look_books = [FactoryGirl.create(:look_book)]
    @services = [FactoryGirl.create(:service)]
  end

  it 'should render' do
    expect{ render }.not_to raise_error
  end
end
