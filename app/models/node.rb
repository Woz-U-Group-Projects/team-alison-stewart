class Node < ActiveRecord::Base
  # Constants
  TYPES = %w{
    Nodes::Photo
    Nodes::Text
  }

  JUNIOR_FIELDS = %w{
    current_grade
    first_name
    homeroom
    identifier
    last_name
    photo_url
    subject_number
    teacher
  }

  # Associations
  belongs_to :owner, polymorphic: true
  has_many :phrases, -> { order(position: :asc) }, dependent: :destroy

  # Attributes
  accepts_nested_attributes_for :phrases, allow_destroy: true

  # Attachments
  mount_uploader :node_photo, PhotoUploader
  mount_uploader :mask, PhotoUploader

  # Gem definitions
  acts_as_list scope: :owner

  # Validations
  validates_presence_of :type
  validates_inclusion_of :type, in: TYPES
  validates_presence_of :name
  validates_presence_of :x
  validates_presence_of :y
  validates_presence_of :width
  validates_numericality_of :width, greater_than: 0
  validates_presence_of :height
  validates_numericality_of :height, greater_than: 0

  # Instance methods
  def text
    value = ''

    phrases.each do |phrase|
      if phrase.text
        value += phrase.prefix if phrase.prefix
        value += phrase.text
        value += phrase.suffix if phrase.suffix
      end
    end

    value
  end
end
