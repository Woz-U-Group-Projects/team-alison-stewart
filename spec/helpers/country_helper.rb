require 'rails_helper'

describe CountryHelper, type: :helper do
  describe '#options_for_countries' do
    it 'should return an array of countries' do
      expect(options_for_countries).to be_a(Array)
    end

    it 'should have Canada as the first country' do
      expect(options_for_countries[0].name).to eq('Canada')
    end

    it 'should have the United States as the second country' do
      expect(options_for_countries[1].name).to eq('United States')
    end
  end

  describe '#options_for_provinces' do
    it 'should return a list of all provinces' do
      expect(options_for_provinces).to be_a(Array)
    end

    it 'should have the Canadian provinces' do
      expect(options_for_provinces).to include(['British Columbia', 'BC', 'CA'])
    end
  end

  describe '#country_long_name' do
    it 'should return the full country name' do
      expect(country_long_name('CA')).to eq('Canada')
    end
  end

  describe '#province_long_name' do
    it 'should return the full province/state name' do
      expect(province_long_name('BC', 'CA')).to eq('British Columbia')
    end
  end
end
