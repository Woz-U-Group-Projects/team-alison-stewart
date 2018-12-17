class DemoVideo < ActiveRecord::Base
  # Assocations
  belongs_to :event_type
  has_many :features, -> { order(position: :asc) }, as: :owner, dependent: :destroy

  # Attachments
  mount_uploader :still_screen, PhotoUploader

  # Validations
  validates_presence_of :event_type
  validates_uniqueness_of :event_type, scope: [:grad_program_code, :grad_group_code]
  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :video_url
end
