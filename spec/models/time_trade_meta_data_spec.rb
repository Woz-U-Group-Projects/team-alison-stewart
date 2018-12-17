require 'rails_helper'

RSpec.describe TimeTradeMetaData, type: :model do
  before do
    @booking = FactoryGirl.create(:booking)
    @school = FactoryGirl.create(:school)
    @time_trade_meta_data = FactoryGirl.create(:time_trade_meta_data, school_code: @school.code, school_id: @school.id)
  end

  subject{ @time_trade_meta_data }

  # Associations
  it { is_expected.to belong_to(:school) }
  it { is_expected.to have_many(:appointment_types).dependent(:destroy) }

  # Validations
  it { is_expected.to validate_presence_of(:school) }

  # Class methods
  describe '#self.for_school_and_faculty_and_sitting_type' do
    before do
      @booking = FactoryGirl.create(:booking)
      @school = FactoryGirl.create(:school)

      @time_trade_meta_data = FactoryGirl.create(:time_trade_meta_data, school_code: @school.code, school_id: @school.id)
      @time_trade_meta_data2 = FactoryGirl.create(:time_trade_meta_data, school_code: @school.code, school_id: @school.id)

      @time_trade_appointment_type = FactoryGirl.create(:time_trade_appointment_type, time_trade_meta_data_id: @time_trade_meta_data.id, photo_type: Sitting::SITTING_TYPE_GRAD)
      @time_trade_appointment_type2 = FactoryGirl.create(:time_trade_appointment_type, time_trade_meta_data_id: @time_trade_meta_data2.id, photo_type: Sitting::SITTING_TYPE_GROUP)
    end

    context 'should return meta data for school when no faculty present' do
      it 'return nil for nil sitting type' do

        expect(TimeTradeMetaData.for_school_and_faculty_and_sitting_type(@time_trade_meta_data.school, nil, nil)).to eq(nil)
      end

      context 'with valid sitting type' do
        it 'should return meta data with the associated appointment type that has a photo type matching the sitting type for grad' do
            @booking.sitting_type = 'grad'
            @booking.save

            expect(TimeTradeMetaData.for_school_and_faculty_and_sitting_type(@time_trade_meta_data.school, nil, Sitting::SITTING_TYPE_GRAD)).to eq(@time_trade_meta_data)
        end

        it 'should return meta data with the associated appointment type that has a photo type matching the sitting type for group' do
            @booking.sitting_type = 'group'
            @booking.save

            expect(TimeTradeMetaData.for_school_and_faculty_and_sitting_type(@time_trade_meta_data.school, nil, Sitting::SITTING_TYPE_GROUP)).to eq(@time_trade_meta_data2)
        end
      end
    end

    context 'should return meta data for faculty when present' do
      before do
        @school2 = FactoryGirl.create(:school)

        @school.parent_school = @school2
        @school.parent_code = @school2.code
        @school.save
      end

      it 'should return meta data with the associated appointment type that has a photo type matching the sitting type for grad' do
          @booking.sitting_type = 'grad'
          @booking.save

          expect(TimeTradeMetaData.for_school_and_faculty_and_sitting_type(@school.parent_school, @time_trade_meta_data.school, Sitting::SITTING_TYPE_GRAD)).to eq(@time_trade_meta_data)
      end

      it 'should return meta data with the associated appointment type that has a photo type matching the sitting type for group' do
          @booking.sitting_type = 'group'
          @booking.save

          expect(TimeTradeMetaData.for_school_and_faculty_and_sitting_type(@school.parent_school, @time_trade_meta_data.school, Sitting::SITTING_TYPE_GROUP)).to eq(@time_trade_meta_data2)
      end

    end

    context 'should return nil when no school or faculty' do
      it 'with nil sitting type' do
        expect(TimeTradeMetaData.for_school_and_faculty_and_sitting_type(nil, nil, nil)).to be_nil
      end

      it 'with valid sitting type' do
        expect(TimeTradeMetaData.for_school_and_faculty_and_sitting_type(nil, nil, Sitting::SITTING_TYPE_GRAD)).to be_nil
      end
    end
  end
end
