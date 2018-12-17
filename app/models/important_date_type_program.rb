class ImportantDateTypeProgram < ActiveRecord::Base
  # Associations
  belongs_to :important_date_type

  # Validations
  validates_presence_of :important_date_type
  validates_presence_of :program_slug
end
