require 'rails_helper'

describe 'shared/_progress_bar.html.erb' do
  it 'should render' do
    expect{ render partial: 'shared/progress_bar' }.not_to raise_error
  end
end
