class ImportantDateType < ActiveRecord::Base
  # Constants
  PHOTO_DAY = '01 Photo Day'
  RETAKE_DAY = '02 Retake Day'
  GRAD_GROUP_PHOTO = '06 Grade 12 Group Photo'
  STAFF_GROUP_PHOTO = '07 Staff Group Photo'
  DINNER_DANCE_GROUP_PHOTO = '08 Dinner Dance Group Photo'
  TEAMS_AND_CLUB_PHOTO = '09 Teams and Club Photos'
  USER_DEFINED_DATE_10 = '10 User Defined Date'
  USER_DEFINED_DATE_11 = '11 User Defined Date'
  USER_DEFINED_DATE_11A = '11a User Defined Date'
  USER_DEFINED_DATE_11B = '11b User Defined Date'
  USER_DEFINED_DATE_11C = '11c User Defined Date'
  USER_DEFINED_DATE_11D = '11d User Defined Date'
  USER_DEFINED_DATE_11E = '11e User Defined Date'
  HS_CONVOCATION = '12 HS Convocation'
  YB_CUT_OFF = '13 YB Cut Off'
  COMP_CUT_OFF = '14 Comp Cut Off'

  HIGHRISE_IMPORTANT_DATE_TYPES = [
    PHOTO_DAY,
    RETAKE_DAY,
    GRAD_GROUP_PHOTO,
    STAFF_GROUP_PHOTO,
    DINNER_DANCE_GROUP_PHOTO,
    TEAMS_AND_CLUB_PHOTO,
    USER_DEFINED_DATE_10,
    USER_DEFINED_DATE_11,
    USER_DEFINED_DATE_11A,
    USER_DEFINED_DATE_11B,
    USER_DEFINED_DATE_11C,
    USER_DEFINED_DATE_11D,
    USER_DEFINED_DATE_11E,
    HS_CONVOCATION,
    YB_CUT_OFF,
    COMP_CUT_OFF
  ]

  # Associations
  has_many :important_dates, dependent: :destroy
  has_many :important_date_type_programs, dependent: :destroy

  # Gem definitions
  acts_as_list

  # Validations
  validates_presence_of :highrise_field
  validates_inclusion_of :highrise_field, in: HIGHRISE_IMPORTANT_DATE_TYPES
  validates_presence_of :code
  validate :name_or_dynamic

  private

  def name_or_dynamic
    errors.add(:base, 'Must have name or be dynamic') if name.blank? && dynamic_name == false
  end
end
