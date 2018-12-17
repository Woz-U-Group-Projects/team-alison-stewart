class JobType < ActiveRecord::Base
  # Associations
  has_many :job_postings, -> { order(position: :asc) }, dependent: :destroy

  # Validations
  validates_presence_of :name

  # Gem definitions
  acts_as_list
end
