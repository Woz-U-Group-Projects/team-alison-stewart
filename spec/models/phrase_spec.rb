require 'rails_helper'

RSpec.describe Phrase, type: :model do
  before do
    @phrase = FactoryGirl.create(:phrase)
  end

  subject{ @phrase }

  # Associations
  it { is_expected.to belong_to(:node) }

  # Validations
  it { is_expected.to validate_presence_of(:name) }
end
