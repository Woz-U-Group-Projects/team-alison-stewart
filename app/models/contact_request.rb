class ContactRequest < ActiveRecord::Base
  # Validations
  validates_presence_of :to_emails
  validates_presence_of :from_email
  validates_format_of :from_email, with: RegexHelper::EMAIL
  validates_presence_of :subject
  validates_presence_of :body
  validate :to_emails_format

  # Callbacks
  after_create :send_email

  private

  def to_emails_format
    return unless to_emails

    error_emails = to_emails.gsub(' ', '').split(',')

    error_emails.each do |email|
      return errors.add(:to_emails, 'has invalid email present') unless email =~ RegexHelper::EMAIL
    end
  end

  def send_email
    ContactRequestMailer.request_email(self).deliver_now
  end
end
