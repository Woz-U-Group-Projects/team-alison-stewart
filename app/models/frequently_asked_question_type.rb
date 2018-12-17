class FrequentlyAskedQuestionType < ActiveRecord::Base
  # Associations
  has_many :frequently_asked_questions, -> { order(position: :asc) }, dependent: :destroy

  # Validations
  validates_presence_of :name

  # Gem definitions
  acts_as_list
end
