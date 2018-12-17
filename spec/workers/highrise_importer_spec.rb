require 'rails_helper'

describe HighriseImporter do
  let(:worker) { HighriseImporter }

  describe '#perform' do
    before(:each) do
      @company = Highrise::Company.new(name: 'Test School')
      @company.set_field_value('Customer ID', 'ABC')

      allow(Highrise::Company).to receive(:find_all_across_pages).and_return([@company])
    end

    it 'should create a school' do
      expect{ worker.perform }.to change{ School.count }.by(1)
    end

    it 'should update school if it already exists' do
      @school = FactoryGirl.create(:school, name: 'Overwrite', code: 'ABC')

      worker.perform

      # @school.reload.name.should eq(@company.name)
      expect(@school.reload.name).to eq(@company.name)
    end

    it 'should send failure email if school cannot be created' do
      @company.set_field_value('Customer ID', nil)

      expect{ worker.perform }.to change{ ActionMailer::Base.deliveries.count }.by(1)
    end

    it 'should set the parent school code correctly' do
      @company.set_field_value('Customer ID', 'UBC-CSC')

      worker.perform

      expect(School.last.parent_code).to eq('UBC')
    end

    it 'should set the grad program code correctly' do
      @company.set_field_value('Grad Program Code', 'SF1')

      worker.perform

      expect(School.last.grad_program_code).to eq('SF1')
    end

    it 'should set the grad group code correctly' do
      @company.set_field_value('Grad Group Code', 'GS')

      worker.perform

      expect(School.last.grad_group_code).to eq('GS')
    end

    it 'should set the school day program code correctly' do
      @company.set_field_value('SD Program Code', 'SB1')

      worker.perform

      expect(School.last.school_day_program_code).to eq('SB1')
    end

    it 'should create a new event' do
      @event_type = FactoryGirl.create(:event_type)
      @company.set_field_value(@event_type.highrise_field, 'Jan 1 2016')

      worker.perform

      event = Event.last
      expect(event.school_id).to eq(School.last.id)
      expect(event.event_type).to eq(@event_type)
      expect(event.date).to eq('Jan 1 2016')
    end

    it 'should update an existing event' do
      @school = FactoryGirl.create(:school, name: 'Test School', code: 'ABC')
      @event_type = FactoryGirl.create(:event_type)
      @event = FactoryGirl.create(:event, school: @school, event_type: @event_type, date: 'Jan 1 2016')
      @company.set_field_value(@event_type.highrise_field, 'Feb 1 2016')

      worker.perform

      expect(@event.reload.date).to eq('Feb 1 2016')
    end

    it 'should delete an existing event' do
      @school = FactoryGirl.create(:school, name: 'Test School', code: 'ABC')
      @event_type = FactoryGirl.create(:event_type)
      @event = FactoryGirl.create(:event, school: @school, event_type: @event_type, date: 'Jan 1 2016')
      @company.set_field_value(@event_type.highrise_field, '')

      worker.perform

      expect{ @event.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'should create a new important date' do
      @important_date_type = FactoryGirl.create(:important_date_type)
      @company.set_field_value(@important_date_type.highrise_field, 'Jan 1 2016')

      worker.perform

      important_date = ImportantDate.last
      expect(important_date.school_id).to eq(School.last.id)
      expect(important_date.important_date_type).to eq(@important_date_type)
      expect(important_date.name).to eq(@important_date_type.name)
      expect(important_date.value).to eq('Jan 1 2016')
    end

    it 'should create a new dynamic important date' do
      @important_date_type = FactoryGirl.create(:important_date_type, dynamic_name: true)
      @company.set_field_value(@important_date_type.highrise_field, 'Test: Jan 1 2016')

      worker.perform

      important_date = ImportantDate.last
      expect(important_date.school_id).to eq(School.last.id)
      expect(important_date.important_date_type).to eq(@important_date_type)
      expect(important_date.name).to eq('Test')
      expect(important_date.value).to eq('Jan 1 2016')
    end

    it 'should update an existing important_date' do
      @school = FactoryGirl.create(:school, name: 'Test School', code: 'ABC')
      @important_date_type = FactoryGirl.create(:important_date_type)
      @important_date = FactoryGirl.create(:important_date, school: @school, important_date_type: @important_date_type, value: 'Jan 1 2016')
      @company.set_field_value(@important_date_type.highrise_field, 'Feb 1 2016')

      worker.perform

      expect(@important_date.reload.value).to eq('Feb 1 2016')
    end

    it 'should delete an existing important_date when regex does not match' do
      @school = FactoryGirl.create(:school, name: 'Test School', code: 'ABC')
      @important_date_type = FactoryGirl.create(:important_date_type, dynamic_name: true)
      @important_date = FactoryGirl.create(:important_date, school: @school, important_date_type: @important_date_type, value: 'Jan 1 2016')
      @company.set_field_value(@important_date_type.highrise_field, 'Test Jan 1 2016')

      worker.perform

      expect{ @important_date.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'should do nothing when regex does not match' do
      @important_date_type = FactoryGirl.create(:important_date_type, dynamic_name: true)
      @company.set_field_value(@important_date_type.highrise_field, 'Test Jan 1 2016')

      expect{ worker.perform }.to_not change{ ImportantDate.count }
    end

    it 'should delete an existing important_date' do
      @school = FactoryGirl.create(:school, name: 'Test School', code: 'ABC')
      @important_date_type = FactoryGirl.create(:important_date_type)
      @important_date = FactoryGirl.create(:important_date, school: @school, important_date_type: @important_date_type, value: 'Jan 1 2016')
      @company.set_field_value(@important_date_type.highrise_field, '')

      worker.perform

      expect{ @important_date.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
