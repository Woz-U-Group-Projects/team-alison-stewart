class Comment < ActiveRecord::Base
  SELECTIONS = [
    'Data Change',
    'New Student',
    'Lost/Stolen - Replacement',
    'Other'
  ]
  # Associations
  belongs_to :user
  belongs_to :owner, polymorphic: true

  # Validations
  validates_presence_of :user
  validates_presence_of :text
end
