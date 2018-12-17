require 'rails_helper'

RSpec.describe Event, type: :model do
  before do
    @event = FactoryGirl.create(:event)
  end

  subject{ @event }

  # Associations
  it { is_expected.to belong_to(:school) }
  it { is_expected.to belong_to(:event_type) }

  # Validations
  it { is_expected.to validate_presence_of(:school) }
  it { is_expected.to validate_presence_of(:event_type) }
  it { is_expected.to validate_uniqueness_of(:event_type).scoped_to(:school_id) }
  it { is_expected.to validate_presence_of(:date) }
end
