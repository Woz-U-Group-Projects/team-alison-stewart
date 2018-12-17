require 'rails_helper'

RSpec.describe Feedback, type: :model do
  before do
    @feedback = FactoryGirl.create(:feedback)
  end

  subject{ @feedback }

  # Validations
  it { is_expected.to validate_presence_of(:from_email) }
  it { is_expected.to validate_presence_of(:subject) }
  it { is_expected.to validate_presence_of(:body) }

  it 'should not allow bad from email' do
    @feedback.from_email = 'test'

    expect(@feedback).not_to be_valid
  end

  # Callbacks
  describe 'after_create' do
    it 'should send request email' do
      expect{ FactoryGirl.create(:feedback) }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
