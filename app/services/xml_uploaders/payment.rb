module XmlUploaders
  class Payment < Base
    # Constants
    FILE_PREFIX = 'P'

    protected

    def presenter_class
      PaymentXmlPresenter
    end

    def xml
      presenter_class.new(booking).to_xml
    end
  end
end
