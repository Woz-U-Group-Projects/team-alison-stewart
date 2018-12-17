class Photo < ActiveRecord::Base
  # Associations
  belongs_to :owner, polymorphic: true

  # Attachments
  mount_uploader :file_name, PhotoUploader

  # Validations
  validates_presence_of :file_name

  # Gem definitions
  acts_as_list scope: :owner
end
