class School < ActiveRecord::Base
  include PgSearch

  # Associations
  has_many :events, -> (school) { includes(:event_type).where('events.school_id = ?', school.id).order('event_types.position') }, dependent: :destroy
  has_many :event_types, through: :events
  has_many :photos, -> { order(position: :asc) }, as: :owner, dependent: :destroy
  has_many :schools, foreign_key: :parent_code, primary_key: :code
  belongs_to :parent_school, class_name: 'School', foreign_key: :parent_code, primary_key: :code
  has_many :time_trade_meta_datas, dependent: :destroy
  has_many :electronic_marketings, -> { order(position: :asc) }, dependent: :destroy
  has_many :convocations, -> { order(ceremony: :asc) }, dependent: :destroy
  has_many :important_dates, -> (school) { includes(:important_date_type).where('important_dates.school_id = ?', school.id).order('important_date_types.position') }, dependent: :destroy
  has_many :important_date_types, through: :important_dates
  has_many :id_card_templates, dependent: :destroy
  has_many :program_notes, dependent: :destroy
  has_one :address, as: :owner, dependent: :destroy
  has_many :users

  # Attachments
  mount_uploader :logo_photo, PhotoUploader

  # Validations
  validates_presence_of :name
  validates_presence_of :code
  validates_uniqueness_of :code
  validate :code_change, on: :update

  # Gem definitions
  pg_search_scope :search,
                  against: [:name, :code],
                  using: {
                    tsearch: { any_word: true, prefix: true },
                    trigram: { threshold: 0.075 }
                  }

  # Scopes
  scope :parent_schools, -> { where(parent_code: nil) }

  # Class methods
  def self.find(input)
    if input.is_a?(Integer) || input =~ RegexHelper::NUMBER
      super
    else
      find_by_code(input)
    end
  end

  # Instance methods
  def to_param
    code
  end

  def sitting_for_event_type(event_type)
    case event_type.program_slug
    when Program::SCHOOL_PHOTO_SLUG
      Sitting.where(event_type_id: event_type.id).first
    when Program::GRADUATION_SLUG, Program::CONVOCATION_SLUG
      sitting = Sitting.where(event_type_id: event_type.id, school_id: id).first
      sitting = Sitting.where(event_type_id: event_type.id, grad_program_code: grad_program_code, school_id: nil).first unless sitting
      sitting = Sitting.where(event_type_id: event_type.id, grad_group_code: grad_group_code, school_id: nil).first unless sitting
      sitting = Sitting.where(event_type_id: event_type.id, grad_program_code: [nil, ''], grad_group_code: [nil, ''], school_id: nil).first unless sitting
      sitting = Sitting.where(event_type_id: event_type.id).first unless sitting

      sitting
    else
      nil
    end
  end

  def electronic_marketing_for_program(program_slug)
    case program_slug
    when Program::SCHOOL_PHOTO_SLUG
      electronic_marketing = ElectronicMarketing.where(program_slug: program_slug, school_id: id).first
      electronic_marketing = ElectronicMarketing.where(program_slug: program_slug, school_day_program_code: school_day_program_code).first unless electronic_marketing
      electronic_marketing = ElectronicMarketing.where(program_slug: program_slug, school_id: nil, school_day_program_code: nil).first unless electronic_marketing
      electronic_marketing
    when Program::GRADUATION_SLUG
      electronic_marketing = ElectronicMarketing.where(program_slug: program_slug, school_id: parent_school.id).first if is_university?
      electronic_marketing = ElectronicMarketing.where(program_slug: program_slug, school_id: id).first unless electronic_marketing
      electronic_marketing = ElectronicMarketing.where(program_slug: program_slug, grad_program_code: grad_program_code,  grad_group_code: grad_group_code, school_id: nil).first unless electronic_marketing
      electronic_marketing = ElectronicMarketing.where(program_slug: program_slug, grad_program_code: grad_program_code,  grad_group_code: nil, school_id: nil).first unless electronic_marketing
      electronic_marketing = ElectronicMarketing.where(program_slug: program_slug, grad_program_code: nil, grad_group_code: grad_group_code, school_id: nil).first unless electronic_marketing
      electronic_marketing = ElectronicMarketing.where(program_slug: program_slug, grad_program_code: nil, grad_group_code: nil, school_id: nil).first unless electronic_marketing
      electronic_marketing
    else
      nil
    end
  end

  def is_university?
    return false if parent_code.nil? || parent_code.empty?
    true
  end

  def program_notes_for_program(program)
    program_notes = self.program_notes.where(program_slug: program.slug)
    program_notes += self.program_notes.where(program_slug: nil)
    program_notes += self.program_notes.where(program_slug: '')

    program_notes
  end

  private

  def code_change
    errors[:code] = 'can not be changed' if self.code_changed?
  end
end
