require 'rails_helper'

describe 'id_card_requests/_help.html.erb' do
  it 'should render' do
    expect{ render partial: 'id_card_requests/help' }.not_to raise_error
  end
end
