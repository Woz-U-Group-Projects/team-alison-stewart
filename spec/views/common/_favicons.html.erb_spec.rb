require 'rails_helper'

describe 'common/_favicons.html.erb' do
  it 'should render' do
    expect{ render partial: 'common/favicons' }.not_to raise_error
  end
end
