require 'rails_helper'

RSpec.describe EventType, type: :model do
  before do
    @event_type = FactoryGirl.create(:event_type)
  end

  subject{ @event_type }

  # Associations
  it { is_expected.to have_many(:events).dependent(:destroy) }
  it { is_expected.to have_many(:sittings).dependent(:destroy) }

  # Validations
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:program_slug) }
  it { is_expected.to validate_presence_of(:highrise_field) }
  it { is_expected.to validate_inclusion_of(:highrise_field).in_array(EventType::HIGHRISE_EVENT_TYPES) }
  it { is_expected.to validate_presence_of(:code) }
end
