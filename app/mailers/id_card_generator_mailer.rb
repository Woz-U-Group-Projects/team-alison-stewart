class IdCardGeneratorMailer < ActionMailer::Base
  default from: 'csr@artonagroup.com'

  # Constants
  EMAILS = [
    'alisons@artona.com'
  ]

  def id_card_generation_failed(id_card_request, message)
    @id_card_request = id_card_request
    @message = message

    @subject    = '[Artona] ID Card Request Failure'
    @recipients = EMAILS

    mail(to: @recipients, subject: @subject)
  end
end
