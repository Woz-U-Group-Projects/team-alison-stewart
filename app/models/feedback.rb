class Feedback < ActiveRecord::Base
  # Validations
  validates_presence_of :from_email
  validates_format_of :from_email, with: RegexHelper::EMAIL
  validates_presence_of :subject
  validates_presence_of :body

  # Callbacks
  after_create :send_email

  private

  def send_email
    FeedbackMailer.feedback_email(self).deliver_now
  end
end
