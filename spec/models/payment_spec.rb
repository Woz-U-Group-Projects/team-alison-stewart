require 'rails_helper'

describe Payment, type: :model do
  before(:each) do
    @payment = FactoryGirl.create(:payment)
  end

  subject { @payment }

  # Associations
  it { is_expected.to belong_to(:booking) }
  it { is_expected.to belong_to(:gateway_transaction) }

  # Validations
  it { is_expected.to validate_presence_of(:amount) }
  it { is_expected.to validate_presence_of(:payment_method) }
  it { is_expected.to validate_presence_of(:received_on) }
  it { is_expected.to validate_presence_of(:booking) }
end
