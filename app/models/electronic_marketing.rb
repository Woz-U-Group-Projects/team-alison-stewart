class ElectronicMarketing < ActiveRecord::Base
  # Associations
  belongs_to :school

  # Attachments
  mount_uploader :file, FileUploader

  # Gem definitions
  acts_as_list scope: :school_id

  # Validations
  validates_presence_of :name
  validates_presence_of :program_slug
end
