require 'rails_helper'

RSpec.describe ContactRequest, type: :model do
  before do
    @contact_request = FactoryGirl.create(:contact_request)
  end

  subject{ @contact_request }

  # Validations
  it { is_expected.to validate_presence_of(:to_emails) }
  it { is_expected.to validate_presence_of(:from_email) }
  it { is_expected.to validate_presence_of(:subject) }
  it { is_expected.to validate_presence_of(:body) }

  it 'should not allow bad from email' do
    @contact_request.from_email = 'test'

    expect(@contact_request).not_to be_valid
  end

  it 'should not allow bad email in to emails' do
    @contact_request.to_emails = 'test@test.org,blah'

    expect(@contact_request).not_to be_valid
  end

  # Callbacks
  describe 'after_create' do
    it 'should send request email' do
      expect{ FactoryGirl.create(:contact_request) }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
