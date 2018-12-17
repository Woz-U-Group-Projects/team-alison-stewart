require 'rails_helper'

describe 'features/_list_item.html.erb' do
  before(:each) do
    @feature = FactoryGirl.create(:feature)
  end

  it 'should render' do
    expect{ render partial: 'features/list_item', locals: { feature: @feature } }.not_to raise_error
  end
end
