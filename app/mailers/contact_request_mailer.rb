class ContactRequestMailer < ActionMailer::Base
  default from: 'csr@artonagroup.com'

  def request_email(contact_request)
    @contact_request = contact_request

    @subject    = "[Artona - Contact Request] #{contact_request.subject}"
    @recipients = contact_request.to_emails.gsub(' ', '').split(',')

    mail(to: @recipients, subject: @subject)
  end
end
