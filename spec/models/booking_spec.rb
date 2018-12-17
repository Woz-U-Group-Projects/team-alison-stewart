require 'rails_helper'

RSpec.describe Booking, type: :model do
  before do
    @booking = FactoryGirl.create(:booking)
  end

  subject{ @booking }

  # Associations
  it { is_expected.to have_one(:address).dependent(:destroy) }
  it { is_expected.to belong_to(:faculty) }
  it { is_expected.to have_one(:payment) }

  # Validations
  it { is_expected.to validate_presence_of(:customer_id) }
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_presence_of(:email_student) }
  it { is_expected.to validate_presence_of(:phone_student) }
  it { is_expected.to validate_presence_of(:phone_parent) }
  it { is_expected.to validate_presence_of(:address) }

  it 'should not allow bad student email' do
    @booking = FactoryGirl.build(:booking, email_student: '123')

    expect(@booking.valid?).to eq(false)
  end

  it 'should not allow bad parent email' do
    @booking = FactoryGirl.build(:booking, email_parent: '123')

    expect(@booking.valid?).to eq(false)
  end

  it 'should not allow bad student phone' do
    @booking = FactoryGirl.build(:booking, phone_student: 'ABC')

    expect(@booking.valid?).to eq(false)
  end

  it 'should not allow bad parent phone' do
    @booking = FactoryGirl.build(:booking, phone_parent: 'ABC')

    expect(@booking.valid?).to eq(false)
  end

  # Callbacks
  describe 'after_initialize' do
    it 'should set the default values' do
      @booking = Booking.new

      expect(@booking.height_ft).to eq(5)
      expect(@booking.height_in).to eq(7)
    end
  end

  # Instance methods
  describe '#phone_student=' do
    it 'should strip all non numeric characters' do
      @booking.phone_student = '(123)-ABC-5555   '

      expect(@booking.phone_student).to eq('1235555')
    end
  end

  describe '#phone_parent=' do
    it 'should strip all non numeric characters' do
      @booking.phone_parent = '(123)-ABC-5555   '

      expect(@booking.phone_parent).to eq('1235555')
    end
  end
end
