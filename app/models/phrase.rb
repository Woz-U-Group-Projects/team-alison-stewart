class Phrase < ActiveRecord::Base
  # Associations
  belongs_to :node

  # Validations
  validates_presence_of :name

  # Gem definitions
  acts_as_list scope: :node
end
