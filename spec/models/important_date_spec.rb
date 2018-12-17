require 'rails_helper'

RSpec.describe ImportantDate, type: :model do
  before do
    @important_date = FactoryGirl.create(:important_date)
  end

  subject{ @important_date }

  # Associations
  it { is_expected.to belong_to(:school) }
  it { is_expected.to belong_to(:important_date_type) }

  # Validations
  it { is_expected.to validate_presence_of(:school) }
  it { is_expected.to validate_presence_of(:important_date_type) }
  it { is_expected.to validate_uniqueness_of(:important_date_type).scoped_to(:school_id) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:value) }
end
