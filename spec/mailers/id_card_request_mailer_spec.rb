require 'rails_helper'

describe IdCardRequestMailer, type: :mailer do
  describe '#new_request' do
    before(:each) do
      @id_card_request = FactoryGirl.create(:id_card_request)
    end

    it 'should email artona' do
      email = IdCardRequestMailer.new_request(@id_card_request)

      expect(email.to).to eq([@id_card_request.attention_of_email])
    end
  end
end
