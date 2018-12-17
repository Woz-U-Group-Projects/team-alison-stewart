require 'rails_helper'

describe Payment::Create, type: :service do
  before(:each) do
    @booking = FactoryGirl.create(:booking)
    @address = FactoryGirl.build(:address)

    @credit_card = {
      first_name: 'Test',
      last_name: 'McTest',
      number: '4111 1111 1111 1111',
      brand: 'visa',
      verification_value: '123',
      month: '01',
      year: Date.today.year + 5
    }

    @booking_params = {
      credit_card: @credit_card
    }
  end

  # Class methods
  describe '#self.process' do
    it 'should create a payment' do
      expect{ Payment::Create.process(@booking, @booking_params) }.to change{ Payment.count }.by(1)
    end

    it 'should create a gateway transaction' do
      expect{ Payment::Create.process(@booking, @booking_params) }.to change{ GatewayTransaction.count }.by(1)
    end

    it 'should set the correct payment amount' do
      payment = Payment::Create.process(@booking, @booking_params)

      expect(payment.amount).to eq(Booking::DEPOSIT_AMOUNT)
    end

    it 'should set the correct gateway transaction amount' do
      payment = Payment::Create.process(@booking, @booking_params)

      expect(payment.gateway_transaction.amount).to eq(Booking::DEPOSIT_AMOUNT)
    end

    it 'should have a successful gateway transaction' do
      payment = Payment::Create.process(@booking, @booking_params)

      expect(payment.gateway_transaction.success).to eq(true)
    end

    it 'should upload the payment' do
      expect(XmlUploaders::Payment).to receive(:enqueue_from_booking)

      payment = Payment::Create.process(@booking, @booking_params)
    end

    it 'should fail when no booking is provided' do
      payment = Payment::Create.process(nil, @booking_params)

      expect(payment.persisted?).to eq(false)
    end

    it 'should fail with bad credit card' do
      @booking_params[:credit_card][:number] = '4111 1111 1111 1112'

      payment = Payment::Create.process(@booking, @booking_params)

      expect(payment.persisted?).to eq(false)
    end
  end
end
