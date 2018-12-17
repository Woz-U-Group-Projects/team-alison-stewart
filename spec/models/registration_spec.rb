require 'rails_helper'

RSpec.describe Registration, type: :model do
  before do
    @registration = FactoryGirl.create(:registration)
  end

  subject{ @registration }

  # Associations
  it { is_expected.to belong_to(:school) }
  it { is_expected.to have_one(:address).dependent(:destroy) }

  # Validations
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_presence_of(:student_number) }
  it { is_expected.to validate_presence_of(:email_address) }
  it { is_expected.to validate_presence_of(:degree) }

  it 'should not allow bad email address' do
    @registration = FactoryGirl.build(:registration, email_address: 'bad')

    expect(@registration.valid?).to eq(false)
  end

  # Instance methods
  describe '#full_name' do
    it 'should return the full name' do
      expect(@registration.full_name).to eq("#{@registration.first_name} #{@registration.middle_name} #{@registration.last_name}")
    end
  end
end
