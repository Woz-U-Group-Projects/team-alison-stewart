class Booking < ActiveRecord::Base
  include AASM

  # Constants
  GENDER_MALE = 'male'
  GENDER_FEMALE = 'female'
  GENDER_OTHER = 'other'
  GENDERS = %w{ male female other }
  DEPOSIT_AMOUNT = 60_00
  STATES = %w{ pending booked }

  # Associations
  has_one :address, as: :owner, dependent: :destroy
  belongs_to :customer
  belongs_to :faculty, class_name: 'School', foreign_key: :faculty_school_code, primary_key: :code
  has_one :payment

  # Attributes
  accepts_nested_attributes_for :address

  # Gem definitions
  auto_strip_attributes :first_name, :last_name

  # Validations
  validates_presence_of :customer_id
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email_student
  validates_presence_of :phone_student
  validates_presence_of :phone_parent
  validates_presence_of :address
  validates_format_of :email_student, with: RegexHelper::EMAIL, on: :create
  validates_format_of :email_parent, with: RegexHelper::EMAIL, on: :create
  validates_format_of :phone_student, with: RegexHelper::PHONE_NUMBER, on: :create
  validates_format_of :phone_parent, with: RegexHelper::PHONE_NUMBER, on: :create
  validates_associated :address

  # Callbacks
  after_initialize :default_values

  # State machine
  aasm column: :state, whiny_transitions: false do
    state :pending, initial: true
    state :booked

    event :book do
      transitions from: :pending, to: :booked
    end
  end

  # Class methods
  def self.from_customer(customer)
    booking = new(
      customer_id: customer.id,
      email_parent: customer.parents_email,
      email_student: customer.email,
      phone_parent: customer.home_phone_number,
      phone_student: customer.phone,
      student_number: customer.student_number
    )

    booking.address = Address.new(
      address1: customer.address_1,
      address2: customer.address_2,
      address3: customer.address_3,
      city: customer.city,
      province: customer.state  || 'BC',
      country: customer.country || 'CA',
      postal_code: customer.postal_code
    )

    booking
  end

  # Instance methods
  def phone_student=(value)
    write_attribute(:phone_student, value&.gsub(/\D/, ''))
  end

  def phone_parent=(value)
    write_attribute(:phone_parent, value&.gsub(/\D/, ''))
  end

  def customer
    @customer ||= Customer.find_by_id(customer_id)
  end

  def height
    "#{height_ft}FEET#{height_in}INCHES"
  end

  def group_sitting?
    sitting_type == Sitting::SITTING_TYPE_GROUP
  end

  def grad_sitting?
    sitting_type == Sitting::SITTING_TYPE_GRAD
  end

  def male?
    gender&.downcase == GENDER_MALE
  end

  def female?
    gender&.downcase == GENDER_FEMALE
  end

  private

  def default_values
    self.height_ft ||= 5
    self.height_in ||= 7
  end
end
