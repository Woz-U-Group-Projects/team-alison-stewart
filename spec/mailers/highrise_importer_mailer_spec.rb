require 'rails_helper'

describe HighriseImporterMailer, type: :mailer do
  describe '#school_import_failed' do
    before(:each) do
      @school = School.new
      @school.save
    end

    it 'should email paul' do
      email = HighriseImporterMailer.school_import_failed(@school)

      expect(email.to[1]).to eq('paull@artona.com')
    end
  end

  describe '#important_date_failed' do
    before(:each) do
      @school = School.new
      @school.save
      @important_date_type = ImportantDateType.new
      @important_date_type.save
    end

    it 'should email paul' do
      email = HighriseImporterMailer.important_date_failed(nil, @important_date_type, @school)

      expect(email.to[1]).to eq('paull@artona.com')
    end
  end
end
