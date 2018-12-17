class FeedbackMailer < ActionMailer::Base
  default from: 'csr@artonagroup.com'

  # Constants
  CSR_EMAIL = [
    'csr@artona.com'
  ]

  def feedback_email(feedback)
    @feedback = feedback

    @subject = '[Artona] New Feedback'
    @recipients = CSR_EMAIL

    mail(to: @recipients, subject: @subject)
  end
end
