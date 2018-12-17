class Service < ActiveRecord::Base
  # Associations
  has_many :photos, -> { order(position: :asc) }, as: :owner, dependent: :destroy
  has_many :features, -> { order(position: :asc) }, as: :owner, dependent: :destroy
  has_many :look_books, dependent: :destroy

  # Attachments
  mount_uploader :preview_photo, PhotoUploader
  mount_uploader :banner_photo, PhotoUploader

  # Validations
  validates_presence_of :title
  validate :contact_emails_format

  # Gem definitions
  acts_as_list

  private

  def contact_emails_format
    return unless contact_emails

    error_emails = contact_emails.gsub(' ', '').split(',')

    error_emails.each do |email|
      return errors.add(:contact_emails, 'has invalid email present') unless email =~ RegexHelper::EMAIL
    end
  end
end
