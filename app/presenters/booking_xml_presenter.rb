require 'builder'

class BookingXmlPresenter
  def initialize(booking, customer_id = nil, free_on_board = 'BOOKED')
    @booking = booking
    @customer_id = customer_id || booking.customer_id
    @free_on_board = free_on_board
  end

  def to_xml
    builder = Builder::XmlMarkup.new(indent: 2)
    address = @booking.address

    xml = builder.xml do |x|
      x.customer do |c|
        c.id @customer_id&.upcase
        c.name [@booking.last_name, @booking.first_name].join(' ' * 4)&.upcase
        c.addr_1 address.address1&.upcase
        c.addr_2 address.address2&.upcase
        c.addr_3 address.address3&.upcase
        c.city address.city&.upcase
        c.state address.province&.upcase
        c.zipcode address.postal_code&.upcase
        c.country address.country&.upcase
        c.contact_email @booking.email_student&.upcase
        c.contact_fax nil
        c.contact_first_name @booking.first_name&.upcase
        c.contact_honorific nil
        c.contact_initial nil
        c.contact_last_name @booking.last_name&.upcase
        c.contact_mobile nil
        c.contact_phone @booking.phone_student&.upcase
        c.contact_position nil
        c.contact_salutation nil
        c.discount_code nil
        c.free_on_board @free_on_board
        c.def_sls_tax_grp_id nil
        c.sic_code nil
        c.ind_code nil
        c.notes nil
        c.ship_via nil
        c.modify_date Time.now.strftime('%Y%m%d')
        c.model_released nil
        c.all_student_number @booking.student_number&.upcase
        c.all_photographed nil
        c.all_gender_male @booking.male? ? 1 : 0
        c.all_gender_female @booking.female? ? 1 : 0
        c.all_shoot_location nil
        c.all_retake_photographed nil
        c.parent_parents_email @booking.email_parent&.upcase
        c.parent_home_phone_number @booking.phone_parent&.upcase
        c.conv_degree nil
        c.conv_gown_size nil
        c.conv_height @booking.height
      end
    end

    xml.to_s
  end
end
