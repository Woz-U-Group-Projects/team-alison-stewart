require 'rails_helper'

RSpec.describe School, type: :model do
  before do
    @school = FactoryGirl.create(:school)
  end

  subject{ @school }

  # Associations
  it { is_expected.to have_many(:events).dependent(:destroy) }
  it { is_expected.to have_many(:event_types) }
  it { is_expected.to have_many(:photos).dependent(:destroy) }
  it { is_expected.to have_many(:schools) }
  it { is_expected.to belong_to(:parent_school) }
  it { is_expected.to have_many(:time_trade_meta_datas).dependent(:destroy) }
  it { is_expected.to have_many(:electronic_marketings).dependent(:destroy) }
  it { is_expected.to have_many(:convocations).dependent(:destroy) }
  it { is_expected.to have_many(:important_dates).dependent(:destroy) }
  it { is_expected.to have_many(:important_date_types) }
  it { is_expected.to have_many(:id_card_templates).dependent(:destroy) }
  it { is_expected.to have_many(:program_notes).dependent(:destroy) }
  it { is_expected.to have_one(:address).dependent(:destroy) }
  it { is_expected.to have_many(:users) }

  # Validations
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:code) }
  it { is_expected.to validate_uniqueness_of(:code) }

  it 'should not allow code to be changed after create' do
    @school.code = 'TEST'

    expect(@school.valid?).to eq(false)
  end

  # Scopes
  describe 'search' do
    it 'should return the schools matching search' do
      @school.name = 'Test School'
      @school.save
      @school2 = FactoryGirl.create(:school, name: 'Some Wrong Name')

      expect(School.search('Test').map(&:id)).to eq([@school.id])
    end
  end

  describe 'parent_schools' do
    it 'should return the schools with no parents' do
      @child_school = FactoryGirl.create(:school, parent_code: @school.code)

      expect(School.parent_schools.map(&:id)).to eq([@school.id])
    end
  end

  # Class methods
  describe '#self.find' do
    it 'should do a traditional find when integer' do
      expect(School.find(@school.id)).to eq(@school)
    end

    it 'should do a traditional find when integer string' do
      expect(School.find("#{@school.id}")).to eq(@school)
    end

    it 'should find by code when string' do
      expect(School.find(@school.code)).to eq(@school)
    end
  end

  # Instance methods
  describe '#to_param' do
    it 'should return the code of the school' do
      expect(@school.to_param).to eq(@school.code)
    end
  end

  describe '#sitting_for_event_type' do
    before(:each) do
      @event_type = FactoryGirl.create(:event_type, program_slug: Program::SCHOOL_PHOTO_SLUG)
      @sitting = FactoryGirl.create(:sitting, event_type: @event_type)
    end

    it 'should return first sitting for event type when school photo' do
      expect(@school.sitting_for_event_type(@event_type)).to eq(@sitting)
    end

    it 'should return the first sitting for event type when graduation and no grad program code' do
      @event_type.program_slug = Program::GRADUATION_SLUG
      @event_type.save

      expect(@school.sitting_for_event_type(@event_type)).to eq(@sitting)
    end

    it 'should return the sitting for event type and grad program code when graduation and grad program code' do
      @school.grad_program_code = 'SF1'
      @school.save

      @event_type.program_slug = Program::GRADUATION_SLUG
      @event_type.save

      @sitting.grad_program_code = 'SF1'
      @sitting.save

      @sitting2 = FactoryGirl.create(:sitting, event_type: @event_type)

      expect(@school.sitting_for_event_type(@event_type)).to eq(@sitting)
    end

    it 'should return the sitting for event type and grad group code when graduation and grad group code' do
      @school.grad_group_code = 'GS'
      @school.save

      @event_type.program_slug = Program::GRADUATION_SLUG
      @event_type.save

      @sitting.grad_group_code = 'GS'
      @sitting.save

      @sitting2 = FactoryGirl.create(:sitting, event_type: @event_type)

      expect(@school.sitting_for_event_type(@event_type)).to eq(@sitting)
    end

    it 'should return the sitting for event type and school code when graduation and school' do
      @event_type.program_slug = Program::GRADUATION_SLUG
      @event_type.save

      @sitting.school = @school
      @sitting.save

      @sitting2 = FactoryGirl.create(:sitting, event_type: @event_type)

      expect(@school.sitting_for_event_type(@event_type)).to eq(@sitting)
    end
  end

  describe '#electronic_marketing_for_program' do
     before(:each) do
       @electronic_marketing = FactoryGirl.create(:electronic_marketing)
     end

     describe '#for school_photo' do
       before(:each) do
         @program_slug = Program::SCHOOL_PHOTO_SLUG
       end

       it 'should default to the electronic marketing with a school photo program slug and nil school day program code' do
         @electronic_marketing.school_id = nil
         @electronic_marketing.school_day_program_code = nil
         @electronic_marketing.save

         expect(@school.electronic_marketing_for_program(@program_slug)).to eq(@electronic_marketing)
       end

       it 'should return the electronic marketing for the selected school if available' do
         @electronic_marketing2 = FactoryGirl.create(:electronic_marketing, school_id: @school.id)

         expect(@school.electronic_marketing_for_program(@program_slug)).to eq(@electronic_marketing2)
       end

       it 'should return the electronic marketing with the corresponding school day program code if available' do
         @electronic_marketing2 = FactoryGirl.create(:electronic_marketing, school_day_program_code: 'SB1')
         @school.school_day_program_code = 'SB1'

         expect(@school.electronic_marketing_for_program(@program_slug)).to eq(@electronic_marketing2)
       end
      end

     describe '#for graduation' do
       before(:each) do
         @program_slug = Program::GRADUATION_SLUG
         @electronic_marketing.program_slug = Program::GRADUATION_SLUG
         @electronic_marketing.save
       end

       it 'should return the electronic marketing with the graduation program slug as default for nil case' do
         @electronic_marketing.school_id = nil
         @electronic_marketing.grad_group_code = nil
         @electronic_marketing.save

         expect(@school.electronic_marketing_for_program(@program_slug)).to eq(@electronic_marketing)
       end

       it 'should return the electronic marketing with both the corresponding grad program code and grad group code' do
         @electronic_marketing2 = FactoryGirl.create(:electronic_marketing, school_id: nil, grad_program_code: 'SF1', grad_group_code: 'GS', program_slug: Program::GRADUATION_SLUG)
         @electronic_marketing3 = FactoryGirl.create(:electronic_marketing, school_id: nil, grad_program_code: 'SF1', grad_group_code: nil, program_slug: Program::GRADUATION_SLUG)
         @electronic_marketing4 = FactoryGirl.create(:electronic_marketing, school_id: nil, grad_program_code: nil, grad_group_code: 'GS', program_slug: Program::GRADUATION_SLUG)

         @school.grad_program_code = 'SF1'
         @school.grad_group_code = 'GS'
         @school.save

         expect(@school.electronic_marketing_for_program(@program_slug)).to eq(@electronic_marketing2)
       end

       it 'should return the electronic marketing with the corresponding grad program code' do
         @school.grad_program_code = 'SF1'
         @school.save

         @electronic_marketing2 = FactoryGirl.create(:electronic_marketing, school_id: nil, grad_program_code: @school.grad_program_code, grad_group_code: nil, program_slug: Program::GRADUATION_SLUG)

         expect(@school.electronic_marketing_for_program(@program_slug)).to eq(@electronic_marketing2)
       end

       it 'should return the electronic marketing with the corresponding grad group code' do
         @electronic_marketing2 = FactoryGirl.create(:electronic_marketing, school_id: nil, grad_program_code: 'SF1', grad_group_code: nil, program_slug: Program::GRADUATION_SLUG)
         @electronic_marketing3 = FactoryGirl.create(:electronic_marketing, school_id: nil, grad_program_code: nil, grad_group_code: 'GS', program_slug: Program::GRADUATION_SLUG)

         @school.grad_group_code = 'GS'
         @school.save

         expect(@school.electronic_marketing_for_program(@program_slug)).to eq(@electronic_marketing3)
       end

       it 'should return the electronic marketing for the selected school if available' do
         @electronic_marketing2 = FactoryGirl.create(:electronic_marketing, school_id: nil, grad_program_code: 'SF1', program_slug: Program::GRADUATION_SLUG)
         @electronic_marketing3 = FactoryGirl.create(:electronic_marketing, school_id: nil, grad_program_code: nil, grad_group_code: 'GS', program_slug: Program::GRADUATION_SLUG)
         @electronic_marketing4 = FactoryGirl.create(:electronic_marketing, school_id: @school.id, grad_program_code: nil, grad_group_code: nil, program_slug: Program::GRADUATION_SLUG)

         expect(@school.electronic_marketing_for_program(@program_slug)).to eq(@electronic_marketing4)
       end

       it 'should return the electronic marketing for the parent code of the selected school if the school is a university' do
         @parent_school = FactoryGirl.create(:school)

         @school.parent_code = @parent_school.code
         @school.save

         @electronic_marketing2 = FactoryGirl.create(:electronic_marketing, school_id: nil, grad_program_code: 'SF1', program_slug: Program::GRADUATION_SLUG)
         @electronic_marketing3 = FactoryGirl.create(:electronic_marketing, school_id: nil, grad_program_code: nil, grad_group_code: 'GS', program_slug: Program::GRADUATION_SLUG)
         @electronic_marketing4 = FactoryGirl.create(:electronic_marketing, school_id: @school.id, grad_program_code: nil, grad_group_code: nil, program_slug: Program::GRADUATION_SLUG)
         @electronic_marketing5 = FactoryGirl.create(:electronic_marketing, school_id: @parent_school.id, grad_program_code: nil, grad_group_code: nil, program_slug: Program::GRADUATION_SLUG)

         expect(@school.electronic_marketing_for_program(@program_slug)).to eq(@electronic_marketing5)
       end
     end

     it 'should return nil if there are no program slug matches' do
       @electronic_marketing.program_slug = 'invalid slug'
       @electronic_marketing.save

       expect(@school.electronic_marketing_for_program(@program_slug)).to eq(nil)
     end
   end

   describe '#is_university?' do
     it 'should return false if the school parent code is empty or nil' do
       @school = FactoryGirl.create(:school)
       expect(@school.is_university?).to eq(false)
     end

     it 'should return true if the school has a parent code' do
       @school = FactoryGirl.create(:school, parent_code: 'UBC')
       expect(@school.is_university?).to eq(true)
     end
   end

  describe '#program_notes_for_program' do
    it 'should return same program program notes' do
      @program_note = FactoryGirl.create(:program_note, program_slug: Program::GRADUATION_SLUG, school: @school)

      expect(@school.program_notes_for_program(Program.find(Program::GRADUATION_SLUG))).to eq([@program_note])
    end

    it 'should return nil program notes' do
      @program_note = FactoryGirl.create(:program_note, program_slug: nil, school: @school)

      expect(@school.program_notes_for_program(Program.find(Program::GRADUATION_SLUG))).to eq([@program_note])
    end

    it 'should return blank program notes' do
      @program_note = FactoryGirl.create(:program_note, program_slug: '', school: @school)

      expect(@school.program_notes_for_program(Program.find(Program::GRADUATION_SLUG))).to eq([@program_note])
    end

    it 'should not return wrong program program notes' do
      @program_note = FactoryGirl.create(:program_note, program_slug: Program::SCHOOL_PHOTO_SLUG, school: @school)

      expect(@school.program_notes_for_program(Program.find(Program::GRADUATION_SLUG))).to eq([])
    end
  end
end
