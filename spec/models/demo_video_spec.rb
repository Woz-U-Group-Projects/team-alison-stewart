require 'rails_helper'

RSpec.describe DemoVideo, type: :model do
  before do
    @demo_video = FactoryGirl.create(:demo_video)
  end

  subject{ @demo_video }

  # Associations
  it { is_expected.to belong_to(:event_type) }
  it { is_expected.to have_many(:features).dependent(:destroy) }

  # Validations
  it { is_expected.to validate_presence_of(:event_type) }
  it { is_expected.to validate_uniqueness_of(:event_type).scoped_to([:grad_program_code, :grad_group_code]) }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_presence_of(:video_url) }
end
