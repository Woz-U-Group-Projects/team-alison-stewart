require 'rails_helper'

describe 'schools/_program_selector.html.erb' do
  before(:each) do
    @school = FactoryGirl.create(:school)
  end

  it 'should render' do
    expect{ render partial: 'schools/program_selector', locals: { school: @school } }.not_to raise_error
  end
end
