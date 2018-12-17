require 'rails_helper'

describe 'shared/_status_tag.html.erb' do
  before(:each) do
    @text = 'requested'
  end

  it 'should render' do
    expect{ render partial: 'shared/status_tag', locals: { text: @text } }.not_to raise_error
  end
end
