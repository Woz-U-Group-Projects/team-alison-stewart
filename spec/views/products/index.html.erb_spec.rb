require 'rails_helper'

describe 'products/index.html.erb' do
  before(:each) do
    @products = [FactoryGirl.create(:product)]
  end

  it 'should render' do
    expect{ render }.not_to raise_error
  end
end
