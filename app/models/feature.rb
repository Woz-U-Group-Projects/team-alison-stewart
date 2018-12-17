class Feature < ActiveRecord::Base
  # Associations
  belongs_to :owner, polymorphic: true

  # Attachments
  mount_uploader :icon, PhotoUploader

  # Validations
  validates_presence_of :owner
  validates_presence_of :description

  # Gem definitions
  acts_as_list scope: :owner
end
