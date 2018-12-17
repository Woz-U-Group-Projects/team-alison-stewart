require 'rails_helper'

describe GatewayTransaction, type: :model do
  before(:each) do
    @gateway_transaction = FactoryGirl.create(:gateway_transaction)
  end

  subject { @gateway_transaction }

  # Associations
  it { is_expected.to have_one(:payment) }

  # Attributes
  it { is_expected.to serialize(:response) }

  # Class methods
  describe '#create_from_response' do
    before(:each) do
      @payment = FactoryGirl.create(:payment)
      @response = double('response', params: '1', success?: true, authorization: '123', message: 'hi')
    end

    it 'should create the gateway transaction' do
      gateway_transaction = GatewayTransaction.create_from_response('purchase', @payment, @response)

      expect(gateway_transaction.action).to eq('purchase')
      expect(gateway_transaction.amount).to eq(@payment.amount)
      expect(gateway_transaction.response).to eq(@response.params)
      expect(gateway_transaction.success).to eq(@response.success?)
      expect(gateway_transaction.reference).to eq(@response.authorization)
      expect(gateway_transaction.message).to eq(@response.message)
    end
  end

  describe '#create_from_error' do
    before(:each) do
      @payment = FactoryGirl.create(:payment)
      @error = double('error', message: 'hi', backtrace: [])
    end

    it 'should create the gateway transaction' do
      gateway_transaction = GatewayTransaction.create_from_error('purchase', @payment, @error)

      expect(gateway_transaction.action).to eq('purchase')
      expect(gateway_transaction.amount).to eq(@payment.amount)
      expect(gateway_transaction.success).to eq(false)
      expect(gateway_transaction.message).to eq("#{@error.message}\n#{@error.backtrace.join("\n")}")
    end
  end
end
