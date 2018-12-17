require 'rails_helper'

describe 'product/_list_item.html.erb' do
  before(:each) do
    @product = FactoryGirl.create(:product)
  end

  it 'should render' do
    expect{ render partial: 'products/list_item', locals: { product: @product } }.not_to raise_error
  end
end
