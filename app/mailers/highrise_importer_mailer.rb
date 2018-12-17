class HighriseImporterMailer < ActionMailer::Base
  default from: 'csr@artonagroup.com'

  # Constants
  EMAILS = [
    'alisons@artona.com'
  ]

  def school_import_failed(school)
    @school = school

    @subject    = '[Artona] School Import'
    @recipients = EMAILS

    mail(to: @recipients, subject: @subject)
  end

  def important_date_failed(important_date = nil, important_date_type, school)
    @school = school
    @important_date = important_date
    @important_date_type = important_date_type

    @subject = '[Artona] Important Date Import'
    @recipients = EMAILS

    mail(to: @recipients, subject: @subject)
  end
end
