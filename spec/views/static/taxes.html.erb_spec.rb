require 'rails_helper'

describe 'static/taxes.html.erb' do
  it 'should render' do
    expect{ render }.not_to raise_error
  end
end
