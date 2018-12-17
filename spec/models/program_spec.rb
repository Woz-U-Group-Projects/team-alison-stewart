require 'rails_helper'

RSpec.describe Program, type: :model do
  before do
    @program = FactoryGirl.create(:program)
  end

  subject{ @program }

  # Attributes
  it { is_expected.to respond_to(:id) }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:slug) }

  # Class methods
  describe '#self.all' do
    it 'should return an array of programs' do
      expect(Program.all[0]).to be_a(Program)
    end
  end

  # Instance methods
  describe '#initialize' do
    it 'should return a program' do
      expect(Program.new).to be_a(Program)
    end
  end

  describe '#to_param' do
    it 'should return the program slug' do
      expect(@program.to_param).to eq(@program.slug)
    end
  end

  describe '#save!' do
    it 'should return true' do
      expect(@program.save!).to eq(true)
    end
  end

  describe '#event_type_ids' do
    it 'should return all event type ids inside the program' do
      @event_type = FactoryGirl.create(:event_type, program_slug: @program.slug)

      expect(@program.event_type_ids).to eq([@event_type.id])
    end
  end

  describe '#important_date_type_ids' do
    it 'should return all important date type ids inside the program' do
      @important_date_type = FactoryGirl.create(:important_date_type)
      @important_date_type_program = FactoryGirl.create(:important_date_type_program, important_date_type: @important_date_type)

      expect(@program.important_date_type_ids).to eq([@important_date_type.id])
    end
  end
end
