require 'rails_helper'

RSpec.describe Feature, type: :model do
  before do
    @feature = FactoryGirl.create(:feature)
  end

  subject{ @feature }

  # Associations
  it { is_expected.to belong_to(:owner) }

  # Validations
  it { is_expected.to validate_presence_of(:owner) }
  it { is_expected.to validate_presence_of(:description) }
end
