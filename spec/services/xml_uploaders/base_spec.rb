require 'rails_helper'

describe XmlUploaders::Base, type: :service do
  before(:each) do
    @customer = FactoryGirl.create(:customer, id: 'TEST17-123')

    @address = FactoryGirl.create(:address,
      address1: 'ADDRESS1-1',
      city: 'CITY-1',
      province: 'PROVINCE-1')

    @booking = FactoryGirl.create(:booking,
      customer: @customer,
      address: @address,
      first_name: 'FIRST_NAME-1',
      last_name: 'LAST_NAME-1',
      email_student: 'EMAIL_STUDENT-1@TEST.COM')

    allow(Resque).to receive(:enqueue).and_return(true)
  end

  # Class methods
  describe '#self.enqueue_from_booking' do
    it 'should enqueue a customer XML upload' do
      expect(Resque).to receive(:enqueue).with(FtpUploader, {
        file_name: "C_#{@customer.id}-#{@booking.id}-#{@booking.updated_at.strftime('%Y%m%d')}.xml",
        content: /.*/,
        booking_id: @booking.id
      })

      XmlUploaders::Customer.enqueue_from_booking(@booking)
    end

    it 'should enqueue a paired customer XML upload' do
      Timecop.freeze(2016, 07, 21) do
        @customer2 = FactoryGirl.create(:customer, id: @customer.id + 'G')

        expect(Resque).to receive(:enqueue).with(FtpUploader, {
          file_name: "C_#{@customer.id}-#{@booking.id}-#{@booking.updated_at.strftime('%Y%m%d')}.xml",
          content: File.read('spec/fixtures/xml/customers/TEST17-123.xml'),
          booking_id: @booking.id
        })

        expect(Resque).to receive(:enqueue).with(FtpUploader, {
          file_name: "C_#{@customer2.id}-#{@booking.id}-#{@booking.updated_at.strftime('%Y%m%d')}.xml",
          content: File.read('spec/fixtures/xml/customers/TEST17-123G.xml'),
          booking_id: @booking.id
        })

        XmlUploaders::Customer.enqueue_from_booking(@booking)
      end
    end

    it 'should enqueue a payment XML upload' do
      @payment = FactoryGirl.create(:payment, booking: @booking)

      expect(Resque).to receive(:enqueue).once

      XmlUploaders::Payment.enqueue_from_booking(@booking)
    end
  end
end
