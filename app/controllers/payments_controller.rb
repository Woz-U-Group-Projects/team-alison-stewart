class PaymentsController < ApplicationController
  include ActiveMerchant::Billing

  # Before filters
  before_filter :fetch_school, only: [:new, :create]
  before_filter :fetch_time_trade_meta_data, only: [:new, :create]
  before_filter :fetch_booking, only: [:new, :create]

  before_filter :ensure_booking_is_editable, only: [:new, :create]

  def new
    @payment = @booking.build_payment
  end

  def create
    if params.dig(:payment, :delayed_payment) != '1'
      # We need to validate the credit card in the controller so we can display
      # errors in the view if needed.
      @credit_card = CreditCard.new(payment_params[:credit_card])
      @credit_card.valid?

      # Attempt the payment
      @payment = Payment::Create.process(@booking, payment_params)

      if @payment&.persisted?
        @booking.book!

        # Upload the customer and its pair
        XmlUploaders::Customer.enqueue_from_booking(@booking)

        redirect_to confirmation_school_booking_path(@school.code, @booking)
      else
        @payment = @booking.build_payment

        flash[:error] = 'Payment could not be completed. See errors below.'
        render :new, status: 422
      end
    else
      @booking.book!

      # Upload the customer and its pair
      XmlUploaders::Customer.enqueue_from_booking(@booking)

      redirect_to TimeTrade.url_for_booking(@booking)
    end
  end

  private

  def fetch_booking
    @booking = Booking.find(params[:booking_id])
    @sitting_type = @booking.sitting_type

  rescue ActiveRecord::RecordNotFound
    return render_error(404, 'The requested booking could not be found.')
  end

  def fetch_school
    @school = School.find_by_code!(params[:school_id])
    @faculty = nil

    if @school.parent_school
      @faculty = @school
      @school = @school.parent_school
    end

  rescue ActiveRecord::RecordNotFound
    return render_error(404, 'The requested school could not be found.')
  end

  def fetch_time_trade_meta_data
    # have to fetch the booking first since it is accessed by association and not in the params
    @booking = Booking.find(params[:booking_id])

    @time_trade_meta_data         = TimeTradeMetaData.for_school_and_faculty_and_sitting_type(@school, @faculty, @booking.sitting_type)
    @time_trade_appointment_type  = TimeTradeAppointmentType.find_by_time_trade_meta_data_id(@time_trade_meta_data&.id)

    return render_error(404, 'Time Trade is not available for school.') unless @time_trade_meta_data && @time_trade_appointment_type
  end

  def ensure_booking_is_editable
    return render_error(404) unless @booking.pending?
  end

  def payment_params
    params.require(:payment).permit(
      credit_card: [
        :brand,
        :first_name,
        :last_name,
        :month,
        :number,
        :verification_value,
        :year
      ]
    )
  end
end
