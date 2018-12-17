require 'rails_helper'

RSpec.describe TimeTradeImport, type: :model do
  before do
    @time_trade_import = FactoryGirl.create(:time_trade_import)
  end

  subject{ @time_trade_import }

  # Instance methods
  describe '#process' do
    before(:each) do
      allow(Resque).to receive(:enqueue).and_return(true)
    end

    it 'should call TimeTradeImporter' do
      expect(Resque).to receive(:enqueue)

      @time_trade_import.process
    end
  end
end
