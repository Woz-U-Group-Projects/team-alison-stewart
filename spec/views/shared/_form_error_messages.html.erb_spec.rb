require 'rails_helper'

describe 'shared/_form_error_messages.html.erb' do
  before(:each) do
    @school = FactoryGirl.build(:school, code: nil)
    @school.valid?
  end

  it 'should render' do
    expect{ render partial: 'shared/form_error_messages', locals: { object: @school } }.not_to raise_error
  end
end
