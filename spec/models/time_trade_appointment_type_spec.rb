require 'rails_helper'

RSpec.describe TimeTradeAppointmentType, type: :model do
  before do
    @time_trade_appointment_type = FactoryGirl.create(:time_trade_appointment_type)
  end

  subject{ @time_trade_appointment_type }

  # Associations
  it { is_expected.to belong_to(:time_trade_meta_data) }

  # Validations
  it { is_expected.to validate_presence_of(:type_id) }
  it { is_expected.to validate_presence_of(:resource_id) }
  it { is_expected.to validate_uniqueness_of(:photo_type).scoped_to(:time_trade_meta_data_id) }
end
