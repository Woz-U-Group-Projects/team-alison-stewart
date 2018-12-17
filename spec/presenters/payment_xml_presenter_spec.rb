require 'rails_helper'

describe PaymentXmlPresenter, type: :presenter do
  before(:each) do
    @customer = FactoryGirl.create(:customer, ID: 'TEST16-123')
    @booking = FactoryGirl.create(:booking, customer: @customer)
    @payment = FactoryGirl.create(:payment, booking: @booking, created_at: Date.parse('2016-04-10'))

    @payment.gateway_transaction.reference = 'ABC123'
    @payment.gateway_transaction.save
  end

  describe '#to_xml' do
    it 'should return a valid XML' do
      xml = File.read('spec/fixtures/xml/payment.xml')

      expect(PaymentXmlPresenter.new(@booking).to_xml).to eq(xml)
    end
  end
end
