class Customer < ActiveRecord::Base
  # Visual
  establish_connection(:visual_database) if Rails.env.production? || Rails.env.staging?

  self.table_name = 'CUSTOMER'
  self.primary_key = 'ID'

  # Constants
  PLACEHOLDER_NAME = 'STUDENT    NEW'
  RESERVED_NAME = 'RESERVED'

  # Associations
  has_many :user_defined_fields, foreign_key: :DOCUMENT_ID

  # Attributes
  attr_writer :first_name, :last_name, :gender
  attr_accessor :height

  alias_attribute :id, :ID
  alias_attribute :address_1, :ADDR_1
  alias_attribute :address_2, :ADDR_2
  alias_attribute :address_3, :ADDR_3
  alias_attribute :city, :CITY
  alias_attribute :state, :STATE
  alias_attribute :postal_code, :ZIPCODE
  alias_attribute :country, :COUNTRY
  alias_attribute :first_name, :CONTACT_FIRST_NAME
  alias_attribute :last_name, :CONTACT_LAST_NAME
  alias_attribute :phone, :CONTACT_PHONE
  alias_attribute :fax, :CONTACT_FAX
  alias_attribute :mobile, :CONTACT_MOBILE
  alias_attribute :email, :CONTACT_EMAIL
  alias_attribute :name, :NAME
  alias_attribute :discount_code, :DISCOUNT_CODE
  alias_attribute :free_on_board, :FREE_ON_BOARD

  # Class methods
  def self.find_by_student_number(student_number)
    customer_ids = UserDefinedField.customer_ids_for_student_number(student_number)
    where(ID: customer_ids)
  end

  def self.find_by_school_code_and_graduation_year(school_code, graduation_year, sitting_type)
    is_group = sitting_type == Sitting::SITTING_TYPE_GROUP

    if is_group
      where('"ID" LIKE ?', "#{school_code}#{Utils.short_year(graduation_year)}%G")
    else
      where('"ID" LIKE ? AND "ID" NOT LIKE ?', "#{school_code}#{Utils.short_year(graduation_year)}%", '%G')
    end
  end

  def self.find_by_student_number_and_graduation_year_and_school_code_and_sitting_type(student_number, graduation_year, school_code, sitting_type)
    find_by_student_number(student_number).
      find_by_school_code_and_graduation_year(school_code, graduation_year, sitting_type)
  end

  def self.find_by_id(customer_id)
    where('ID' => customer_id)[0]
  end

  def self.find_by_name(name)
    first_name, last_name = name.split(' ')

    where(CONTACT_FIRST_NAME: first_name, CONTACT_LAST_NAME: last_name)
  end

  def self.reserve_new(school_code, graduation_year, sitting_type)
    customers = find_by_school_code_and_graduation_year(school_code, graduation_year, sitting_type).where("\"NAME\" = \'#{PLACEHOLDER_NAME}\'")

    return nil if customers.empty?

    new_customer = find_first_available_customer(customers)

    if new_customer
      new_customer.name = RESERVED_NAME
      new_customer.save!
    end

    new_customer
  end

  def self.reserve_paired_customer(customer)
    return unless customer&.id

    p_customer = customer.paired_customer

    if p_customer&.name == PLACEHOLDER_NAME
      p_customer.name = RESERVED_NAME
      p_customer.save!
    end
  end

  def self.find_first_available_customer(customers)
    # check if the other sitting type records is opened up in Visual
    if customers[0].paired_customer
      # convert to array first before shift method can be used
      # find the first available customer where its paired customer is also available
      customers = customers.to_a
      customers.shift until customers[0].paired_customer.name == PLACEHOLDER_NAME
      customers[0]
    else
      customers[0]
    end
  end

  # Dynamic methods
  UserDefinedField::FIELD_MAPPINGS.keys.each do |field_name|
    define_method(field_name) do
      cached_user_defined_field(field_name).try :value
    end
  end

  # Instance methods
  def school
    school_code = id.split('-').first[0...-2]

    School.find_by(code: school_code)
  end

  def paired_customer
    if self.id.ends_with?('G')
      Customer.find_by_id(self.id.chomp('G'))
    else
      Customer.find_by_id(self.id + 'G')
    end
  end


  private

  def cached_user_defined_fields
    @cached_user_defined_fields ||= user_defined_fields.to_a
  end

  def cached_user_defined_field(field_name)
    cached_user_defined_fields.find do |field|
      field.ID == UserDefinedField::FIELD_MAPPINGS[field_name][:name]
    end
  end
end
