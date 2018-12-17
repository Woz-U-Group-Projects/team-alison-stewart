require 'rails_helper'

describe 'products/_index_preview.html.erb' do
  it 'should render' do
    expect{ render partial: 'products/index_preview' }.not_to raise_error
  end
end
