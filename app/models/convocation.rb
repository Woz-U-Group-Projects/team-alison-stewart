class Convocation < ActiveRecord::Base
  # Associations
  belongs_to :school

  # Validations
  validates_presence_of :ceremony
  validates_presence_of :school
end
