require 'rails_helper'

describe 'highrise_importer_mailer/school_import_failed.text.erb' do
  before(:each) do
    @school = School.new
    @school.save
  end

  it 'should render' do
    expect{ render }.not_to raise_error
  end
end
