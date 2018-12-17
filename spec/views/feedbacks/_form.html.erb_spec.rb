require 'rails_helper'

describe 'feedbacks/_form.html.erb' do
  it 'should render' do
    expect{ render partial: 'feedbacks/form' }.not_to raise_error
  end
end
