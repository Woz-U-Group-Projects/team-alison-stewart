require 'rails_helper'

RSpec.describe Product, type: :model do
  before do
    @product = FactoryGirl.create(:product)
  end

  subject{ @product }

  # Validations
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_presence_of(:platform) }
  it { is_expected.to validate_inclusion_of(:platform).in_array(Product::PLATFORMS) }

  # Scopes
  describe 'platform' do
    it 'should return products for the platform' do
      expect(Product.platform(@product.platform).map(&:id)).to eq([@product.id])
    end
  end
end
