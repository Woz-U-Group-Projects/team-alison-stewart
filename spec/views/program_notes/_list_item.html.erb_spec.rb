require 'rails_helper'

describe 'program_notes/_list_item.html.erb' do
  before(:each) do
    @program_note = FactoryGirl.create(:program_note)
  end

  it 'should render' do
    expect{ render partial: 'program_notes/list_item', locals: { program_note: @program_note } }.not_to raise_error
  end
end
