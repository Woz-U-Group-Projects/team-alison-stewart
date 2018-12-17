require 'rails_helper'

describe 'modals/_contact_request_modal.html.erb' do
  it 'should render' do
    expect{ render partial: 'modals/contact_request_modal', locals: { to_emails: 'test@test.com' } }.not_to raise_error
  end
end
