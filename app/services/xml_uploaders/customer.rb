module XmlUploaders
  class Customer < Base
    attr_reader :free_on_board

    # Constants
    FILE_PREFIX = 'C'

    def enqueue
      @free_on_board = 'BOOKED'

      enqueue_ftp_uploader

      paired_customer = booking.customer.paired_customer

      if paired_customer
        @customer_id    = paired_customer.id
        @free_on_board  = nil

        enqueue_ftp_uploader
      end
    end

    protected

    def presenter_class
      BookingXmlPresenter
    end

    def xml
      presenter_class.new(booking, customer_id, free_on_board).to_xml
    end

    private

    def enqueue_ftp_uploader
      Resque.enqueue(FtpUploader, {
        file_name: file_name,
        content: xml,
        booking_id: booking.id
      })
    end
  end
end
