require 'rails_helper'

RSpec.describe ElectronicMarketing, type: :model do
  before do
    @electronic_marketing = FactoryGirl.create(:electronic_marketing)
  end

  subject{ @electronic_marketing }

  # Associations
  it { is_expected.to belong_to(:school) }

  # Validations
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:program_slug) }
end
