require 'rails_helper'

describe 'look_books/_list_item.html.erb' do
  before(:each) do
    @look_book = FactoryGirl.create(:look_book)
  end

  it 'should render' do
    expect{ render partial: 'look_books/list_item', locals: { look_book: @look_book } }.not_to raise_error
  end
end
