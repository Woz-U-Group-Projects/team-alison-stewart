require 'rails_helper'

describe IdCardGeneratorMailer, type: :mailer do
  describe '#id_card_generation_failed' do
    before(:each) do
      @id_card_request = FactoryGirl.create(:id_card_request)
    end

    it 'should email paul' do
      email = IdCardGeneratorMailer.id_card_generation_failed(@id_card_request, 'message')

      expect(email.to[0]).to eq('paull@artona.com')
    end
  end
end
