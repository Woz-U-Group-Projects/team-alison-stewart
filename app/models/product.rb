class Product < ActiveRecord::Base
  # Constants
  PLATFORMS = %w{ junior senior }

  # Attachments
  mount_uploader :preview_photo, PhotoUploader

  # Validations
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :platform
  validates_inclusion_of :platform, in: PLATFORMS

  # Gem definitions
  acts_as_list

  # Scopes
  scope :platform, -> platform { where(platform: platform) }
end
