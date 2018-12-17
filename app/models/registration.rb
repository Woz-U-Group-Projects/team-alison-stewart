class Registration < ActiveRecord::Base
  # Constants
  REGISTRATION_TYPES = [
    ['student',   'No, I am the graduate!'],
    ['relative',  'Yes, I am a proud relative or friend!']
  ]

  # Associations
  belongs_to :school
  has_one :address, as: :owner, dependent: :destroy

  # Attributes
  accepts_nested_attributes_for :address

  # Validations
  validates_presence_of :school
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :student_number
  validates_presence_of :email_address
  validates_format_of :email_address, with: RegexHelper::EMAIL
  validates_presence_of :degree

  # Instance methods
  def full_name
    [first_name, middle_name, last_name].join ' '
  end
end
