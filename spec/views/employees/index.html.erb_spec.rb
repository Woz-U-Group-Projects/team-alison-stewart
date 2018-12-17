require 'rails_helper'

describe 'employees/index.html.erb' do
  before(:each) do
    @employees = [FactoryGirl.create(:employee)]
  end

  it 'should render with employees' do
    expect{ render }.not_to raise_error
  end

  it 'should render without employees' do
    @employees = []

    expect{ render }.not_to raise_error
  end
end
