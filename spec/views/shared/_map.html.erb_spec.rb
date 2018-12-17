require 'rails_helper'

describe 'shared/_map.html.erb' do
  it 'should render' do
    expect{ render partial: 'shared/map' }.not_to raise_error
  end
end
