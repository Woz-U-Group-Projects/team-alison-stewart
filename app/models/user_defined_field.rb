class UserDefinedField < ActiveRecord::Base
  # Visual
  establish_connection(:visual_database) if Rails.env.production? || Rails.env.staging?

  self.table_name = 'USER_DEF_FIELDS'
  self.primary_key = 'ROWID'

  # Constants
  FIELD_MAPPINGS = {
    composite_choice:    { name: 'UDF-0000014', value: :string },
    student_number:      { name: 'UDF-0000015', value: :string },
    photographed:        { name: 'UDF-0000017', value: :date },
    model_released:      { name: 'UDF-0000018', value: :bool },
    gender_male:         { name: 'UDF-0000019', value: :bool},
    gender_female:       { name: 'UDF-0000020', value: :bool},
    coupon_code:         { name: 'UDF-0000021', value: :string },
    web_password:        { name: 'UDF-0000022', value: :string },
    retake_photographed: { name: 'UDF-0000023', value: :date },
    shoot_location:      { name: 'UDF-0000027', value: :string },
    degree:              { name: 'UDF-0000029', value: :string },
    ceremony:            { name: 'UDF-0000030', value: :string },
    parents_email:       { name: 'UDF-0000173', value: :string },
    home_phone_number:   { name: 'UDF-0000177', value: :num }
  }

  # Associations
  belongs_to :customer, foreign_key: :DOCUMENT_ID

  # Attributes
  alias_attribute :id, :ROWID

  # Class methods
  def self.customer_ids_for_student_number(student_number)
    where(
      ID: FIELD_MAPPINGS[:student_number][:name],
      STRING_VAL: student_number
    ).select(:DOCUMENT_ID).to_a.collect(&:DOCUMENT_ID)
  end
end
