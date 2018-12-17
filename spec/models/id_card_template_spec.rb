require 'rails_helper'

RSpec.describe IdCardTemplate, type: :model do
  before do
    @id_card_template = FactoryGirl.create(:id_card_template)
  end

  subject{ @id_card_template }

  # Associations
  it { is_expected.to have_many(:nodes).dependent(:destroy) }
  it { is_expected.to belong_to(:school) }
  it { is_expected.to have_many(:id_card_requests).dependent(:restrict_with_error) }

  # Validations
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name).scoped_to(:school_id) }
end
