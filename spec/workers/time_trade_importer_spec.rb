require 'rails_helper'

describe TimeTradeImporter do
  let(:worker) { TimeTradeImporter }

  describe '#perform' do
    before(:each) do
      @time_trade_import = FactoryGirl.create(:time_trade_import)
      @school = FactoryGirl.create(:school, code: 'BRIT')

      # Mimic what TimeTradeImport.process does
      temp_file = Tempfile.new(TimeTradeImport::TEMP_FILE_NAME)

      temp_file.binmode
      temp_file << open(Rails.root.join('spec', 'fixtures', 'time_trade', 'import.csv')).read
      temp_file.close

      @params = {
        'time_trade_import_id' => @time_trade_import.id,
        'file_path' => temp_file.path
      }
    end

    it 'should print to the import log' do
      worker.perform(@params)

      expect(@time_trade_import.reload.import_log).not_to be_nil
    end

    it 'should create meta data for school' do
      expect{ worker.perform(@params) }.to change{ TimeTradeMetaData.count }.by(1)
    end

    it 'should create appointment type for school meta data' do
      expect{ worker.perform(@params) }.to change{ TimeTradeAppointmentType.count }.by(2)
    end
  end
end
