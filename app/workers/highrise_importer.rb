class HighriseImporter
  @queue = :high

  ARTONA_PHOTO_CLIENT_TAG = 2810028

  def self.perform
    # Import all companies which are actually schools
    companies = Highrise::Company.find_all_across_pages(params: { tag_id: ARTONA_PHOTO_CLIENT_TAG })

    companies.each do |company|
      update_school_from_company(company)
    end
  end

  def self.update_school_from_company(company)
    school = School.find_by_code(company.field('Customer ID'))

    if school
      school.update_attributes({
        name: company.name,
        parent_code: parent_school_code_from_company(company),
        grad_program_code: company.field('Grad Program Code'),
        grad_group_code: company.field('Grad Group Code'),
        school_day_program_code: company.field('SD Program Code')
      })
    else
      school = create_school_from_company(company)
    end

    # Update the school's address
    update_address_from_company(school, company) if school

    # Import all the events
    update_events_from_company(school, company) if school

    # Import all the important dates
    update_important_dates_from_company(school, company) if school
  end

  def self.create_school_from_company(company)
    school = School.new({
      name: company.name,
      code: company.field('Customer ID'),
      parent_code: parent_school_code_from_company(company),
      grad_program_code: company.field('Grad Program Code'),
      grad_group_code: company.field('Grad Group Code'),
      school_day_program_code: company.field('SD Program Code')
    })

    unless school.save
      HighriseImporterMailer.school_import_failed(school).deliver_now
      return nil
    end

    school
  end

  def self.parent_school_code_from_company(company)
    return nil unless company.field('Customer ID')

    codes = company.field('Customer ID').split('-')

    return nil unless codes.length > 1

    # This will return the 2nd last code in the codes array
    # Ex: UBC-FAC will return UBC
    # EX: UVIC-CSC-SENG will return CSC
    codes[codes.length-2]
  end

  def self.update_address_from_company(school, company)
    # CompanyData is a dynamic model through ActiveResource::Base
    # so it may not be present at all and will cause errors if not
    return nil unless company.respond_to?(:contact_data)

    school.build_address unless school.address

    school.address.address1 = company.contact_data.addresses.first&.street
    school.address.city = company.contact_data.addresses.first&.city
    school.address.province = company.contact_data.addresses.first&.state
    school.address.country = company.contact_data.addresses.first&.country
    school.address.postal_code = company.contact_data.addresses.first&.zip

    if school.address.valid?
      school.save
    else
      school.address.destroy
    end
  end

  def self.update_events_from_company(school, company)
    EventType.all.each do |event_type|
      value = company.field(event_type.highrise_field)
      event = school.events.where(event_type_id: event_type.id).first

      if !value.blank?
        # Update existing event
        if event
          event.date = value
          event.save
        else
          # Create new event
          event = Event.create(school: school, event_type: event_type, date: value)
        end
      elsif value.blank? && event
        # Destroy event
        event.destroy
      end
    end
  end

  def self.update_important_dates_from_company(school, company)
    ImportantDateType.all.each do |important_date_type|
      name  = important_date_type.name
      value = company.field(important_date_type.highrise_field)

      important_date = school.important_dates.where(important_date_type_id: important_date_type.id).first

      if !value.blank?
        # Get dynamic info if needed
        if important_date_type.dynamic_name
          match = value.match(RegexHelper::DYNAMIC_NAME)

          if match
            name, value = match.captures
          else
            HighriseImporterMailer.important_date_failed(important_date, important_date_type, school).deliver_now
            return important_date&.destroy
          end

          name = name&.strip
          value = value&.strip
        end

        # Update existing important date
        if important_date
          important_date.name = name
          important_date.value = value

        important_date.save
        else
          # Create new important date
          important_date = ImportantDate.create(school: school, important_date_type: important_date_type, name: name, value: value)
        end
      elsif value.blank? && important_date
        # Destroy important date
        important_date.destroy
      end
    end
  end
end
