class Payment < ActiveRecord::Base
  include HasMoney

  # Constants
  CARD_TYPES = [['Visa', 'visa'], ['MasterCard', 'master']]

  # Associations
  belongs_to :booking
  belongs_to :gateway_transaction

  has_money :amount

  attr_accessor :delayed_payment
  attr_accessor :credit_card
  attr_accessor :first_name, :last_name, :number, :brand, :verification_value, :month, :year

  # Validations
  validates_presence_of :amount
  validates_presence_of :payment_method
  validates_presence_of :received_on
  validates_presence_of :booking

  # Callbacks
  before_validation :ensure_uuid

  private

  def ensure_uuid
    self.uuid ||= SecureRandom.urlsafe_base64
  end
end
