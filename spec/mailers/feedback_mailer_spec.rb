require "rails_helper"

RSpec.describe FeedbackMailer, type: :mailer do
  describe '#feedback_email' do
    before(:each) do
      @feedback = FactoryGirl.create(:feedback)
    end

    it 'should email Artona CSR email' do
      email = FeedbackMailer.feedback_email(@feedback)
      expect(email.to[0]).to eq('csr@artona.com')
    end
  end
end
