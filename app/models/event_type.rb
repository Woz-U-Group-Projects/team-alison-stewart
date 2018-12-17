class EventType < ActiveRecord::Base
  # Constances
  BUSINESS_PORTRAIT_SESSIONS = 'Business Portrait Sessions'
  GRAD_SESSIONS       = '03 Grad Sessions'
  GRAD_GROUP_SESSIONS = '04 Grad Group Sessions'
  UNIV_CONV_FALL      = 'Univ Convocation Fall'
  UNIV_CONV_SPRING    = 'Univ Convocation Spring'

  HIGHRISE_EVENT_TYPES = [
    BUSINESS_PORTRAIT_SESSIONS,
    GRAD_SESSIONS,
    GRAD_GROUP_SESSIONS,
    UNIV_CONV_FALL,
    UNIV_CONV_SPRING
  ]

  # Associations
  has_many :events, dependent: :destroy
  has_many :sittings, dependent: :destroy

  # Gem definitions
  acts_as_list

  # Validations
  validates_presence_of :name
  validates_presence_of :program_slug
  validates_presence_of :highrise_field
  validates_inclusion_of :highrise_field, in: HIGHRISE_EVENT_TYPES
  validates_presence_of :code
end
