require 'rails_helper'

describe 'contact_requests/_form.html.erb' do
  it 'should render' do
    expect{ render partial: 'contact_requests/form', locals: { to_emails: 'test@test.com' } }.not_to raise_error
  end
end
