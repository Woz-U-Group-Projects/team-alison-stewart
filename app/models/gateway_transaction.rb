class GatewayTransaction < ActiveRecord::Base
  include HasMoney

  # Associations
  has_one :payment

  # Attributes
  serialize :response

  has_money :amount

  # Class methods
  def self.create_from_response(action, payment, response)
    create! action:     action,
            amount:     payment.amount,
            success:    response.success?,
            reference:  response.authorization,
            message:    response.message,
            response:   response.params
  rescue => e
    Rails.logger.info("#{e.message}#{e.backtrace.join("\n")}")
    nil
  end

  def self.create_from_error(action, payment, error)
    create! action:   action,
            amount:   payment.amount,
            success:  false,
            message:  "#{error.message}\n#{error.backtrace.join("\n")}"
  rescue => e
    Rails.logger.info("#{e.message}#{e.backtrace.join("\n")}")
    nil
  end
end
