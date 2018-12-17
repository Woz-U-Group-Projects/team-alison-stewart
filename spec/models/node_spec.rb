require 'rails_helper'

RSpec.describe Node, type: :model do
  before do
    @node = FactoryGirl.create(:node)
  end

  subject{ @node }

  # Associations
  it { is_expected.to belong_to(:owner) }
  it { is_expected.to have_many(:phrases).dependent(:destroy) }

  # Validations
  it { is_expected.to validate_presence_of(:type) }
  it { is_expected.to validate_inclusion_of(:type).in_array(Node::TYPES) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:x) }
  it { is_expected.to validate_presence_of(:y) }
  it { is_expected.to validate_presence_of(:width) }
  it { is_expected.to validate_numericality_of(:width).is_greater_than(0) }
  it { is_expected.to validate_presence_of(:height) }
  it { is_expected.to validate_numericality_of(:height).is_greater_than(0) }

  # Instance methods
  describe '#text' do
    it 'should return all phrases as a string' do
      @phrase = FactoryGirl.create(:phrase, prefix: 'GR: ', suffix: ' ')
      @node = @phrase.node

      expect(@node.text).to eq(@phrase.prefix + @phrase.text + @phrase.suffix)
    end
  end
end
