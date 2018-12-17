require 'rails_helper'

describe 'schools/show.html.erb' do
  before(:each) do
    @school = FactoryGirl.create(:school)
  end

  it 'should render when high school' do
    expect{ render }.not_to raise_error
  end

  it 'should render when faculty' do
    @school.parent_code = FactoryGirl.create(:school).code
    @school.save

    expect{ render }.not_to raise_error
  end

  it 'should render when university' do
    @faculty = FactoryGirl.create(:school, parent_code: @school.code)

    expect{ render }.not_to raise_error
  end
end
