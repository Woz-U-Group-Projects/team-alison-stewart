require 'rails_helper'

describe 'employees/_list_item.html.erb' do
  before(:each) do
    @employee = FactoryGirl.create(:employee)
  end

  it 'should render' do
    expect{ render partial: 'employees/list_item', locals: { employee: @employee } }.not_to raise_error
  end
end
