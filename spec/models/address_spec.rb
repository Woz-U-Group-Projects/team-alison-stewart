require 'rails_helper'

RSpec.describe Address, type: :model do
  before do
    @address = FactoryGirl.create(:address)
  end

  subject{ @address }

  # Associations
  it { is_expected.to belong_to(:owner) }

  # Validations
  it { is_expected.to validate_presence_of(:address1) }
  it { is_expected.to validate_presence_of(:city) }
  it { is_expected.to validate_presence_of(:province) }
  it { is_expected.to validate_presence_of(:country) }
  it { is_expected.to validate_presence_of(:postal_code) }

  it 'should not allow bad postal code when in Canada' do
    @address = FactoryGirl.build(:address, country: 'Canada', postal_code: '12345')

    expect(@address.valid?).to eq(false)
  end

  it 'should not allow bad zip code when in the United States' do
    @address = FactoryGirl.build(:address, country: 'United States', postal_code: 'V9A 4P7')

    expect(@address.valid?).to eq(false)
  end

  # Instance methods
  describe '#in_canada?' do
    it 'should be true when in Canada' do
      @address.country = 'Canada'

      expect(@address.in_canada?).to eq(true)
    end
  end

  describe '#in_usa?' do
    it 'should be true when in the USA' do
      @address.country = 'United States'

      expect(@address.in_usa?).to eq(true)
    end
  end

  describe '#street_address' do
    it 'should return all address lines' do
      @address.address1 = '1'
      @address.address2 = '2'
      @address.address3 = '3'

      expect(@address.street_address).to eq('1, 2, 3')
    end
  end
end
