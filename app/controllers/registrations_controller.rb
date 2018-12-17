class RegistrationsController < ApplicationController
  # Before filters
  before_filter :fetch_school
  before_filter :ensure_registrations_enabled

  def new
    @registration = Registration.new

    @registration.school = @school
    @registration.build_address({
      country: @school.address&.country,
      province: @school.address&.province
    })
  end

  def create
    @registration = Registration.new(registration_params)

    @registration.school = @school

    if @registration.save
      redirect_to confirmation_school_registrations_path(@school.code)
    else
      flash[:error] = 'Cannot save registration. See errors below.'
      return render :new, status: 422
    end
  end

  def confirmation
  end

  private

  def fetch_school
    @school = School.find_by_code!(params[:school_id])
  rescue ActiveRecord::RecordNotFound
    return render_error(404)
  end

  def ensure_registrations_enabled
    render_error(404) unless @school.registrations_enabled
  end

  def registration_params
    params.require(:registration).permit(
      :first_name,
      :middle_name,
      :last_name,
      :student_number,
      :email_address,
      :degree,
      :registration_type,
      :ceremony,
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
