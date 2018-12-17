require 'rails_helper'

RSpec.describe Convocation, type: :model do
  before do
    @convocation = FactoryGirl.create(:convocation)
  end

  subject{ @convocation }

  # Associations
  it { is_expected.to belong_to(:school) }

  # Validations
  it { is_expected.to validate_presence_of(:ceremony) }
  it { is_expected.to validate_presence_of(:school) }
end
