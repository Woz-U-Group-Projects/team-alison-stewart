class LookBook < ActiveRecord::Base
  # Assocations
  belongs_to :service
  has_many :photos, -> { order(position: :asc) }, as: :owner

  # Validations
  validates_presence_of :service
end
