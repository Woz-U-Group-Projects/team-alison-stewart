require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryGirl.create(:comment)
  end

  subject{ @comment }

  # Associations
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:owner) }

  # Validations
  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:text) }
end
