class ImportantDate < ActiveRecord::Base
  # Associations
  belongs_to :school
  belongs_to :important_date_type

  # Delegations
  delegate :position, to: :important_date_type

  # Validations
  validates_presence_of :school
  validates_presence_of :important_date_type
  validates_uniqueness_of :important_date_type, scope: :school_id
  validates_presence_of :name
  validates_presence_of :value
end
