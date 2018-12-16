require 'uri'

class TimeTrade
  extend CountryHelper

  def self.url_for_booking(booking)
    school  = booking.customer.school
    faculty = booking.faculty
    sitting_type = booking.sitting_type

    meta_data = TimeTradeMetaData.for_school_and_faculty_and_sitting_type(school, faculty, sitting_type)

    # Make sure time trade meta data is available before continuing
    return nil unless meta_data

    appointment_type = meta_data.appointment_types.find_by(photo_type: sitting_type)

    # Make sure time trade appointment type is available before continuing
    return nil unless appointment_type

    URI::HTTPS.build(
      host: host,
      path: '/app/app382/workflows/artona001/schedule',
      query: HashToQuery.convert({
        appointmentTypeGroupId:             meta_data.appointment_type_group_id,
        appointmentTypeId:                   appointment_type.type_id,
        attendee_customField1:              booking.customer_id,
        attendee_address_city:              booking.address.city,
        attendee_address_country:          country_long_name(booking.address.country),
        attendee_address_postalCode:      booking.address.postal_code,
        attendee_address_state:            province_long_name(booking.address.province, booking.address.country),
        attendee_address_streetAddress:   booking.address.street_address,
        attendee_companyName:             meta_data.company_name,
        attendee_email:                     booking.email_student,
        attendee_memberId:                 booking.student_number,
        attendee_person_firstName:        booking.first_name,
        attendee_person_lastName:         booking.last_name,
        attendee_phone_phoneNumber:      booking.phone_student,
        attendee_mobile_phoneNumber:     booking.phone_parent,
        campaignId:                         meta_data.campaign_id,
        locationId:                          'artona'
      })
    ).to_s
  end

  private

  def self.host
    if Rails.env.production-live?
      'www.timetrade.com'
    else
      'ui-stage.timetradesystems.com'
    end
  end
end
