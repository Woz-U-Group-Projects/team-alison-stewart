require 'rails_helper'

describe 'shared/_general_help.html.erb' do
  it 'should render' do
    expect{ render partial: 'shared/general_help' }.not_to raise_error
  end
end
