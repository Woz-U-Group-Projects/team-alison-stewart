class IdCardTemplate < ActiveRecord::Base
  # Associations
  belongs_to :school
  has_many :nodes, -> { order(:position) }, as: :owner, dependent: :destroy
  has_many :id_card_requests, dependent: :restrict_with_error

  # Attachments
  mount_uploader :base_photo, PhotoUploader

  # Validations
  validates_presence_of :name
  validates_uniqueness_of :name, scope: :school_id
end
