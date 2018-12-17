class TimeTradeAppointmentType < ActiveRecord::Base
  # Associations
  belongs_to :time_trade_meta_data

  # Validations
  validates_presence_of :type_id
  validates_presence_of :resource_id
  validates_uniqueness_of :photo_type, scope: :time_trade_meta_data_id
end
