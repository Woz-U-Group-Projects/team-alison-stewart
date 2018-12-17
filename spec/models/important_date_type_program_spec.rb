require 'rails_helper'

RSpec.describe ImportantDateTypeProgram, type: :model do
  before do
    @important_date_type_program = FactoryGirl.create(:important_date_type_program)
  end

  subject{ @important_date_type_program }

  # Associations
  it { is_expected.to belong_to(:important_date_type) }

  # Validations
  it { is_expected.to validate_presence_of(:important_date_type) }
  it { is_expected.to validate_presence_of(:program_slug) }
end
