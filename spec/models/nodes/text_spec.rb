require 'rails_helper'

RSpec.describe Nodes::Text, type: :model do
  before do
    @text_node = FactoryGirl.create(:text_node)
  end

  subject{ @text_node }

  # Validations
  it { is_expected.to validate_presence_of(:font_family) }
  it { is_expected.to validate_presence_of(:point_size) }
  it { is_expected.to validate_numericality_of(:point_size).is_greater_than(0) }
  it { is_expected.to validate_presence_of(:color) }
end
