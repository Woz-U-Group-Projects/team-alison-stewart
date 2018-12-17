require 'rails_helper'

RSpec.describe Setting, type: :model do
  before do
    @setting = FactoryGirl.create(:setting, key: 'test', value: '123')
  end

  subject{ @setting }

  # Class methods
  describe '#self.method_missing' do
    it 'should find an existing setting and change its value' do
      expect{ Setting.test = 'test' }.to_not change(Setting, :count)

      expect(Setting.test).to eq('test')
    end

    it 'should create a new setting when it does not exist' do
      expect{ Setting.test_setting = 'test' }.to change(Setting, :count).by(1)

      expect(Setting.test_setting).to eq('test')
    end

    it 'should find existing setting' do
      expect(Setting.test).to eq(123)
    end
  end
end
