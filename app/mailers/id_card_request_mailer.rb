class IdCardRequestMailer < ActionMailer::Base
  default from: 'idcard@artona.com'

  def new_request(id_card_request)
    @id_card_request = id_card_request

    @subject    = '[Artona] New ID Card Request'
    @recipients = id_card_request.attention_of_email
    @cc         = 'alisons@artona.com'

    mail(to: @recipients, subject: @subject)
  end
end
