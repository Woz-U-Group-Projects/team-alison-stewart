class TimeTradeMetaData < ActiveRecord::Base
  # Associations
  belongs_to :school
  has_many :appointment_types, class_name: 'TimeTradeAppointmentType', dependent: :destroy

  # Validations
  validates_presence_of :school

  # Class methods
  def self.for_school_and_faculty_and_sitting_type(school, faculty, sitting_type)
    return nil unless (faculty || school) && sitting_type
    if faculty && school
      time_trade_meta_datas = where(school_code: faculty.code)
    else
      time_trade_meta_datas = where(school_code: school.code)
    end

    return nil if time_trade_meta_datas.empty?

    self.fetch_time_trade_meta_data(time_trade_meta_datas, sitting_type)
  end

  private

  def self.fetch_time_trade_meta_data(time_trade_meta_datas, sitting_type)
    time_trade_meta_datas.each do |ttmd|
      return ttmd if ttmd.try(:appointment_types).find_by(photo_type: sitting_type)
    end

    return nil
  end
end
