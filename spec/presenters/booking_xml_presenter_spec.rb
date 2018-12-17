require 'rails_helper'

describe BookingXmlPresenter, type: :presenter do
  let(:booking) do
    Booking.new.tap do |booking|
      booking.customer_id = 'USFU14-0092'
      booking.student_number = '301117448'
      booking.first_name = 'ELAINE'
      booking.last_name = 'LI'
      booking.email_parent = 'ELAINE9172@GMAIL.COM'
      booking.email_student = 'YILINGL@SFU.CA'
      booking.phone_parent = nil
      booking.phone_student = '7788989176'
      booking.gender = Booking::GENDER_FEMALE
      booking.height_ft = 5
      booking.height_in = 5
      booking.address = Address.new(
        address1: '7551-MALAHAT AVENUE',
        address2: nil,
        address3: nil,
        city: 'RICHMOND',
        province: 'BC',
        country: 'CA',
        postal_code: 'V7A4H1'
      )
    end
  end

  let(:presenter) { BookingXmlPresenter.new(booking) }

  describe '#to_xml' do
    it 'should return a valid XML' do
      Timecop.freeze(2014, 4, 10) do
        xml = File.read('spec/fixtures/xml/customer.xml')

        expect(presenter.to_xml).to eq(xml)
      end
    end
  end
end
