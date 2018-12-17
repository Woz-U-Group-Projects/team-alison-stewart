require 'rails_helper'

RSpec.describe JobType, type: :model do
  before do
    @job_type = FactoryGirl.create(:job_type)
  end

  subject{ @job_type }

  # Associations
  it { is_expected.to have_many(:job_postings).dependent(:destroy) }

  # Validations
  it { is_expected.to validate_presence_of(:name) }
end
