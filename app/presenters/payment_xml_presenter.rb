require 'builder'

class PaymentXmlPresenter
  def initialize(booking)
    @booking = booking
    @payment = booking.payment
  end

  def to_xml
    builder = Builder::XmlMarkup.new(indent: 2)

    xml = builder.xml do |x|
      x.payment do |p|
        p.customer_id @booking.customer.id&.upcase
        p.amount '%.2f' % (@payment.amount_in_dollars)
        p.payment_date @payment.created_at.strftime('%m/%d/%Y')
        p.web_payment_method @payment.payment_method.upcase
        p.web_staff_user_id 'BS'
        p.web_payment_confirmation @payment.gateway_transaction.reference
      end
    end

    xml.to_s
  end
end
