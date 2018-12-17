require 'rails_helper'

describe 'modals/_look_book_modal.html.erb' do
  before(:each) do
    @look_book = FactoryGirl.create(:look_book)
  end

  it 'should render' do
    expect{ render partial: 'modals/look_book_modal', locals: { look_book: @look_book } }.not_to raise_error
  end
end
