class FrequentlyAskedQuestion < ActiveRecord::Base
  # Associations
  belongs_to :frequently_asked_question_type

  # Attributes
  attr_accessor :text

  # Validations
  validates_presence_of :question
  validates_presence_of :answer
  validates_presence_of :frequently_asked_question_type

  # Gem definitions
  acts_as_list scope: [:frequently_asked_question_type_id]

  # Scopes
  scope :frequently_asked_question_type, -> frequently_asked_question_type { where(frequently_asked_question_type: frequently_asked_question_type) }
end
