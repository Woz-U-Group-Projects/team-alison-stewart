require 'rails_helper'

RSpec.describe Sitting, type: :model do
  before do
    @sitting = FactoryGirl.create(:sitting)
  end

  subject{ @sitting }

  # Associations
  it { is_expected.to belong_to(:event_type) }
  it { is_expected.to belong_to(:school) }
  it { is_expected.to have_many(:features).dependent(:destroy) }

  # Validations
  it { is_expected.to validate_presence_of(:event_type) }
  it { is_expected.to validate_uniqueness_of(:event_type).scoped_to([:grad_program_code, :grad_group_code, :school_id]) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:duration) }
  it { is_expected.to validate_presence_of(:sitting_type) }
  it { is_expected.to validate_inclusion_of(:sitting_type).in_array(Sitting::SITTING_TYPES) }
end
