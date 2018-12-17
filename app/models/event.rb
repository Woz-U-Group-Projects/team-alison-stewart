class Event < ActiveRecord::Base
  # Associations
  belongs_to :school
  belongs_to :event_type

  # Delegations
  delegate :position, to: :event_type

  # Validations
  validates_presence_of :school
  validates_presence_of :event_type
  validates_uniqueness_of :event_type, scope: :school_id
  validates_presence_of :date
end
