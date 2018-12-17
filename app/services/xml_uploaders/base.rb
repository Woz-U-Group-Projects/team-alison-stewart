module XmlUploaders
  class Base
    attr_reader :booking
    attr_reader :customer_id

    def initialize(booking)
      @booking = booking
      @customer_id = booking.customer_id
    end

    def self.enqueue_from_booking(booking)
      self.new(booking).enqueue
    end

    def enqueue
      Resque.enqueue(FtpUploader, {
        file_name: file_name,
        content: xml,
        booking_id: booking.id
      })
    end

    protected

    def presenter_class
      raise 'Must override #presenter_class in subclasses'
    end

    def xml
      raise 'Must override #xml in subclasses'
    end

    private

    def file_name
      "#{self.class::FILE_PREFIX}_#{customer_id}-#{booking.id}-#{booking.updated_at.strftime('%Y%m%d')}.xml"
    end
  end
end
