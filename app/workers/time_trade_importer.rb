require 'csv'

class TimeTradeImporter
  @queue = :high

  COL_SCHOOL_NAME = 'School Name'
  COL_SCHOOL_CODE = 'School_Code'
  COL_CAMPAIGN_ID = 'campaignID'
  COL_COMPANY_NAME = 'attendee_CompanyName'
  COL_GROUP_ID = 'appointmentTypeGroupID'
  COL_PHOTO_TYPE = 'Photo Type'
  COL_RESOURCE_ID = 'resourceId'
  COL_TYPE_ID = 'appointmentTypeID'

  REQUIRED_COLS = [
    COL_SCHOOL_NAME,
    COL_SCHOOL_CODE,
    COL_CAMPAIGN_ID,
    COL_COMPANY_NAME,
    COL_GROUP_ID,
    COL_PHOTO_TYPE,
    COL_RESOURCE_ID,
    COL_TYPE_ID
  ]

  def self.perform(params)
    time_trade_import = TimeTradeImport.find(params['time_trade_import_id'])

    row_number  = 1
    import_log  = ''

    import_log << "Starting import\n"

    # Delete all the old data
    TimeTradeMetaData.all.destroy_all

    CSV.foreach(params['file_path'], headers: true) do |row|
      row_number += 1

      if missing_data?(row)
        import_log << "Missing data in row #{row_number}\n"
        import_log << '  ' + row.to_s + "\n"
        next
      end

      school_code = row[COL_SCHOOL_CODE]
      campaign_id = row[COL_CAMPAIGN_ID]
      school = School.find_by(code: school_code)

      if school.present?
        update_school(school, campaign_id, row)
        import_log << "#{school.name} with Campaign ID '#{campaign_id} imported\n" if school
      else
        import_log << "#{school.name} with Campaign ID '#{campaign_id} not found\n" if school
      end
    end

    import_log << "Finished import\n"

    time_trade_import.import_log = import_log
    time_trade_import.save
  end

  def self.missing_data?(row)
    REQUIRED_COLS.any? do |field|
      row[field].blank?
    end
  end

  def self.update_school(school, campaign_id, row)
    group_id      = row[COL_GROUP_ID]
    type_id       = row[COL_TYPE_ID]
    company_name  = row[COL_COMPANY_NAME]
    photo_type    = row[COL_PHOTO_TYPE].downcase
    resource_id   = row[COL_RESOURCE_ID]

    # Create the meta data if it doesn't exist
    unless meta_data = school.time_trade_meta_datas.where(campaign_id: campaign_id, appointment_type_group_id: group_id, company_name: company_name, school_code: school.code, school_id: school.id).first
      meta_data = TimeTradeMetaData.create(campaign_id: campaign_id, appointment_type_group_id: type_id, company_name: company_name, school_code: school.code, school_id: school.id)
    end

    meta_data.update_attributes(
      campaign_id: campaign_id,
      appointment_type_group_id: group_id,
      company_name: company_name
    )

    attrs = {
      type_id: type_id,
      photo_type: photo_type,
      resource_id: resource_id
    }

    unless appointment_type = meta_data.appointment_types.where(type_id: type_id).first
      appointment_type = meta_data.appointment_types.build
    end

    appointment_type.update_attributes(attrs)
  end
end
