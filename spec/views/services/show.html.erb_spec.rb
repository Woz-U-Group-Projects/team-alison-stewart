require 'rails_helper'

describe 'services/show.html.erb' do
  before(:each) do
    @service = FactoryGirl.create(:service)
  end

  it 'should render' do
    expect{ render }.not_to raise_error
  end
end
