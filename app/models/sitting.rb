class Sitting < ActiveRecord::Base
  # Constants
  SITTING_TYPE_GRAD = 'grad'
  SITTING_TYPE_GROUP = 'group'
  SITTING_TYPES = %w{ grad group }

  # Associations
  belongs_to :event_type
  belongs_to :school
  has_many :features, -> { order(position: :asc) }, as: :owner, dependent: :destroy

  # Validations
  validates_presence_of :event_type
  validates_uniqueness_of :event_type, scope: [:grad_program_code, :grad_group_code, :school_id]
  validates_presence_of :name
  validates_presence_of :duration
  validates_presence_of :sitting_type
  validates_inclusion_of :sitting_type, in: SITTING_TYPES
end
