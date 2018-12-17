class BookingsController < ApplicationController
  # Before filters
  before_filter :fetch_school, only: [:create, :edit, :update, :confirmation]
  before_filter :fetch_booking, only: [:edit, :update, :confirmation]
  before_filter :fetch_time_trade_meta_data, only: [:create, :edit, :update]
  before_filter :fetch_customer, only: [:create]

  before_filter :ensure_booking_is_editable, only: [:edit, :update]
  before_filter :ensure_booking_is_booked, only: [:confirmation]

  def create
    @booking = Booking.from_customer(@customer)
    @booking.assign_attributes(booking_params)

    @booking.faculty_school_code = @faculty&.code

    if @booking.save(validate: false)
      redirect_to edit_school_booking_path(@school.code, @booking)
    else
      return render_error(500)
    end
  end

  def edit
    @booking.address || @booking.build_address
  end

  def update
    if @booking.update_attributes(booking_params)
      @booking.book!

      # Upload the customer and its pair
      XmlUploaders::Customer.enqueue_from_booking(@booking)

      redirect_to TimeTrade.url_for_booking(@booking)
    else
      flash[:error] = 'Cannot save booking. See errors below.'
      render :edit, status: 422
    end
  end

  def thank_you
  end

  private

  def fetch_booking
    @booking = Booking.find(params[:id])

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
    sitting_type = params.dig(:booking, :sitting_type) || @booking.sitting_type

    @time_trade_meta_data         = TimeTradeMetaData.for_school_and_faculty_and_sitting_type(@school, @faculty, sitting_type)
    @time_trade_appointment_type  = TimeTradeAppointmentType.find_by_time_trade_meta_data_id(@time_trade_meta_data&.id)

    return render_error(404, 'Time Trade is not available for school.') unless @time_trade_meta_data && @time_trade_appointment_type
  end

  def fetch_customer
    unless params.dig(:booking, :student_number).blank?
      @customers = Customer.find_by_student_number_and_graduation_year_and_school_code_and_sitting_type(
        params.dig(:booking, :student_number),
        params.dig(:booking, :graduation_year),
        @school.code,
        params.dig(:booking, :sitting_type)
      )

      @customer = @customers[0]

      unless @customer
        @customer = Customer.reserve_new(@school.code, params.dig(:booking, :graduation_year), params.dig(:booking, :sitting_type))

        Customer.reserve_paired_customer(@customer)
      end
    end

    return render_error(404, 'The requested student could not be found.') unless @customer
  end

  def ensure_booking_is_editable
    return render_error(404) unless @booking.pending?
  end

  def ensure_booking_is_booked
    return redirect_to edit_school_booking_path(@school.code, @booking) unless @booking.booked?
  end

  def booking_params
    params.require(:booking).permit(
      :booking_id,
      :email_parent,
      :email_student,
      :faculty_school_code,
      :first_name,
      :gender,
      :graduation_year,
      :height_ft,
      :height_in,
      :last_name,
      :phone_parent,
      :phone_student,
      :sitting_type,
      :student_number,
      address_attributes: [
        :owner_type,
        :owner_id,
        :address1,
        :address2,
        :address3,
        :city,
        :country,
        :province,
        :postal_code
      ]
    )
  end
end
