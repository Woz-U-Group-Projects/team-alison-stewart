require 'rails_helper'

RSpec.describe ImportantDateType, type: :model do
  before do
    @important_date_type = FactoryGirl.create(:important_date_type)
  end

  subject{ @important_date_type }

  # Associations
  it { is_expected.to have_many(:important_dates).dependent(:destroy) }
  it { is_expected.to have_many(:important_date_type_programs).dependent(:destroy) }

  # Validations
  it { is_expected.to validate_presence_of(:highrise_field) }
  it { is_expected.to validate_inclusion_of(:highrise_field).in_array(ImportantDateType::HIGHRISE_IMPORTANT_DATE_TYPES) }
  it { is_expected.to validate_presence_of(:code) }

  it 'should not allow no name and not be dynamic name' do
    @important_date_type.name = ''
    @important_date_type.dynamic_name = false

    expect(@important_date_type.valid?).to eq(false)
  end
end
