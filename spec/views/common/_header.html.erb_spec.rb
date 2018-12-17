require 'rails_helper'

describe 'common/_header.html.erb' do
  before do
      allow(view).to receive(:user_signed_in?).and_return(true)
  end

  it 'should render' do
    expect{ render partial: 'common/header' }.not_to raise_error
  end
end
