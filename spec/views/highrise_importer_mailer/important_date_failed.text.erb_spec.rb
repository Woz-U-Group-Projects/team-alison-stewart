require 'rails_helper'

describe 'highrise_importer_mailer/school_import_failed.text.erb' do
  before(:each) do
    @school = School.new
    @school.save

    @important_date_type = ImportantDateType.new
    @important_date_type.save
  end

  context 'with an important date object' do
    @important_date = ImportantDate.new
    @important_date.save

    it 'should render' do
      expect{ render }.not_to raise_error
    end
  end

  context 'without an important date object' do

  end

end
