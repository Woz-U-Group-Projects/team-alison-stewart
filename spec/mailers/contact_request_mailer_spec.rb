require 'rails_helper'

describe ContactRequestMailer, type: :mailer do
  describe '#request_email' do
    before(:each) do
      @contact_request = FactoryGirl.create(:contact_request)
    end

    it 'should email artona' do
      email = ContactRequestMailer.request_email(@contact_request)

      expect(email.to).to eq(@contact_request.to_emails.gsub(' ', '').split(','))
    end
  end
end
