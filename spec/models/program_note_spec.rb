require 'rails_helper'

RSpec.describe ProgramNote, type: :model do
  before do
    @program_note = FactoryGirl.create(:program_note)
  end

  subject{ @program_note }

  # Associations
  it { is_expected.to belong_to(:school) }

  # Validations
  it { is_expected.to validate_presence_of(:school) }
  it { is_expected.to validate_presence_of(:text) }
end
