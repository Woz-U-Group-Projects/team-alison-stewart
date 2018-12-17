class Address < ActiveRecord::Base
  # Associations
  belongs_to :owner, polymorphic: true

  # Constants
  CONFIG = Rails.application.secrets

  # Gem definitions
  auto_strip_attributes :address1, :address2, :address3

  # Validations
  validates_presence_of :address1
  validates_presence_of :city
  validates_presence_of :province
  validates_presence_of :country
  validates_presence_of :postal_code
  validates_format_of :postal_code, with: RegexHelper::POSTAL_CODE, on: :create, if: :in_canada?
  validates_format_of :postal_code, with: RegexHelper::ZIP_CODE, on: :create, if: :in_usa?

  # Instance methods
  def in_canada?
    self.country == 'Canada' ? true : false
  end

  def in_usa?
    self.country == 'United States' ? true : false
  end

  def street_address
    [
      address1,
      address2,
      address3
    ].compact.join(', ')
  end
end
