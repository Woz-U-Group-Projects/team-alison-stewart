require 'rails_helper'

describe 'modals/_codabar_modal.html.erb' do
  it 'should render' do
    expect{ render partial: 'modals/codabar_modal' }.not_to raise_error
  end
end
