require 'rails_helper'

describe 'static/community.html.erb' do
  it 'should render' do
    expect{ render }.not_to raise_error
  end
end
