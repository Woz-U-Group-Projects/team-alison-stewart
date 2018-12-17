class JobPosting < ActiveRecord::Base
  # Associations
  belongs_to :job_type

  # Attributes
  attr_accessor :text

  # Validations
  validates_presence_of :name
  validates_presence_of :title

  # Gem definitions
  acts_as_list scope: [:job_type_id]

  # Scopes
  scope :job_type, -> job_type { where(job_type: job_type) }

  # Class methods
  def self.has_active_postings?
    self.where("expiry_date >= ?", Time.zone.now).count > 0 || self.where(expiry_date: nil).count > 0
  end

  def self.has_active_postings_for_job_type?(job_postings, job_type_id)
    return true if job_postings.where("expiry_date >= ?", Time.zone.now).count > 0 || job_postings.where(expiry_date: nil).count > 0
    false
  end

  # Instance methods
  def is_expired?
    return false if expiry_date.nil? || (expiry_date > Time.zone.now)
    true
  end
end
