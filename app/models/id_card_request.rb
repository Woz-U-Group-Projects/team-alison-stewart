class IdCardRequest < ActiveRecord::Base
  include AASM

  # Associations
  belongs_to :id_card_template
  belongs_to :school
  has_many :nodes, -> { order(:position) }, as: :owner, dependent: :destroy
  has_many :comments, as: :owner, dependent: :destroy

  # Attributes
  accepts_nested_attributes_for :nodes
  accepts_nested_attributes_for :comments

  # Attachments
  mount_uploader :result_photo, PhotoUploader
  mount_uploader :result_pdf, FileUploader

  # Validations
  validates_presence_of :id_card_template
  validates_presence_of :school
  validates_presence_of :attention_of
  validates_presence_of :attention_of_email
  validates_format_of :attention_of_email, with: RegexHelper::EMAIL, message: 'Please enter a valid e-mail address.'

  validate :unique_request

  # API Scopes
  scope :state, -> state { where(state: state) }

  # Callbacks
  before_validation :ensure_uuid

  # State machine
  aasm column: :state, whiny_transitions: false do
    state :pending, initial: true
    state :requested
    state :errored
    state :rendered
    state :processed
    state :shipped

    event :request, after: [:clear_renders, :render_request] do
      transitions from: :pending, to: :requested, after: :send_new_request
      transitions from: :errored, to: :requested
      transitions from: :rendered, to: :requested
      transitions from: :processed, to: :requested
      transitions from: :shipped, to: :requested
    end

    event :error do
      transitions from: :requested, to: :errored
    end

    event :render do
      transitions from: :requested, to: :rendered
      transitions from: :errored, to: :rendered
    end

    event :process do
      transitions from: :rendered, to: :processed
    end

    event :ship do
      transitions from: :processed, to: :shipped
    end
  end

  private

  def unique_request
    return if student_number.blank?

    # All requests for same student, where they are not past the state of rendered
    existing_requests = IdCardRequest.where(school: school, student_number: student_number)
                                     .where(state: ['pending', 'requested', 'rendered'])

    # Don't count the self record
    existing_requests = existing_requests.where('id != ?', id) if id

    errors.add(:base, 'A request already exists for this student ID #') if existing_requests.count > 0
  end

  def ensure_uuid
    self.uuid ||= SecureRandom.urlsafe_base64
  end

  def send_new_request
    IdCardRequestMailer.new_request(self).deliver_now
  end

  def clear_renders
    self.remove_result_photo!
    self.remove_result_pdf!

    self.save
  end

  def render_request
    Resque.enqueue(IdCardGenerator, id_card_request_id: self.id)
  end
end
