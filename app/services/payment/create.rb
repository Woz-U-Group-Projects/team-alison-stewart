require 'active_merchant/billing/rails'

class Payment::Create
  def self.process(booking, payment_params)
    @credit_card  = build_credit_card(payment_params[:credit_card])
    @payment      = build_payment(booking)
    @gateway      = build_gateway

    process_payment
  end

  private

  def self.build_credit_card(attributes)
    return nil unless attributes

    ActiveMerchant::Billing::CreditCard.new(attributes)
  end

  def self.build_payment(booking)
    payment = Payment.new(booking: booking)

    payment.amount = Booking::DEPOSIT_AMOUNT
    payment.payment_method = @credit_card.brand
    payment.received_on = Time.now

    # Don't allow double payments
    old_payment = Payment.find_by_booking_id(payment.booking_id)
    return nil if old_payment

    payment
  end

  def self.build_gateway
    if Rails.env.production?
      ActiveMerchant::Billing::ExactGateway.new(
        login:     Rails.application.secrets.AM_LOGIN,
        password:  Setting.exact_password)
    else
      ActiveMerchant::Billing::BogusGateway.new
    end
  end

  def self.process_payment
    unless @payment&.valid? && @credit_card.valid? && @gateway
      return @payment
    end

    gateway_options = {
      order_id: @payment.booking.customer_id,
      booking: @payment.booking_id,
      description: 'Artona Booking Services'
    }

    begin
      response = @gateway.purchase(@payment.amount, @credit_card, gateway_options)
    rescue => e
      GatewayTransaction.create_from_error('purchase', @payment, e)
      return @payment
    end

    gateway_transaction = GatewayTransaction.create_from_response('purchase', @payment, response)

    if response.success?
      @payment.gateway_transaction = gateway_transaction
      @payment.save

      # Upload the payment to Artona FTP
      XmlUploaders::Payment.enqueue_from_booking(@payment.booking)
    else
      @credit_card.errors.add :number, 'was declined. Please use another card and try again.'
    end

    @payment
  end
end
