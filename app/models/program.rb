class Program
  # Constants
  SCHOOL_PHOTO_SLUG = 'school_photo'
  GRADUATION_SLUG   = 'graduation'
  CONVOCATION_SLUG  = 'convocation'

  JUNIOR_LINK = 'https://artona.schooldayphoto.com'
  SENIOR_LINK = 'https://artonagroup.picsdigital.com'

  # Grad Program Code
  IN_STUDIO = ['SF0', 'SF1', 'SC0', 'SC1', 'US0', 'US1', 'US0C', 'US1', 'US1C']
  ON_LOCATION = ['L0', 'L1', 'UL0', 'UL0C', 'UL1', 'UL1C']
  MOBILE = ['M0', 'M1', 'UM0', 'UM0C', 'UM1', 'UM1C']

  # School Day Program Code
  BULK_DELIVERY = ['SB1', 'UB1', 'UB2']
  HOME_DELIVERY = ['SM1', 'UM1', 'EM2']

  # Attributes
  attr_accessor :id
  attr_accessor :name
  attr_accessor :slug
  attr_accessor :description

  # Class methods
  def self.all
    [
      {
        id: 1,
        name: 'School Photo',
        slug: SCHOOL_PHOTO_SLUG
      },
      { id: 2,
        name: 'Graduation',
        slug: GRADUATION_SLUG
      },
      { id: 3,
        name: 'Convocation',
        slug: CONVOCATION_SLUG
      }
    ].map { |p| new(p) }
  end

  def self.find(param)
    all.detect { |p| p.to_param == param }
  end

  # Instance methods
  def initialize(params = {})
    @id           = params[:id]
    @name         = params[:name]
    @slug         = params[:slug]
    @description  = params[:description]
  end

  def to_param
    @slug
  end

  def save!
    # Simply for factory girl support
    true
  end

  def event_type_ids
    EventType.where(program_slug: @slug).map { |e| e.id }
  end

  def important_date_type_ids
    ImportantDateTypeProgram.where(program_slug: @slug).map { |idtp| idtp.important_date_type.id }.uniq
  end
end
