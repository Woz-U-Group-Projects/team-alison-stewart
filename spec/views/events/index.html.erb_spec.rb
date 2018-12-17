require 'rails_helper'

describe 'events/index.html.erb' do
  before(:each) do
    @school = FactoryGirl.create(:school)
  end

  it 'should render' do
    expect{ render }.not_to raise_error
  end
end
