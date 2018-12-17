class ProgramNote < ActiveRecord::Base
  # Associations
  belongs_to :school

  # Validations
  validates_presence_of :text
  validates_presence_of :school
end
