require 'rails_helper'

describe LookBookHelper, type: :helper do
  describe '#carousel_length' do
    it 'should return MAX_CAROUSEL_SIZE when equal to it' do
      expect(carousel_length(LookBookHelper::MAX_CAROUSEL_SIZE)).to eq(LookBookHelper::MAX_CAROUSEL_SIZE)
    end

    it 'should return MAX_CAROUSEL_SIZE when larger than it' do
      expect(carousel_length(LookBookHelper::MAX_CAROUSEL_SIZE + 1)).to eq(LookBookHelper::MAX_CAROUSEL_SIZE)
    end

    it 'should return itself when smaller than MAX_CAROUSEL_SIZE' do
      expect(carousel_length(LookBookHelper::MAX_CAROUSEL_SIZE - 1)).to eq(LookBookHelper::MAX_CAROUSEL_SIZE - 1)
    end
  end

  describe '#carousel_highlighted?' do
    it 'should return true when equal to MAX_CAROUSEL_SIZE' do
      expect(carousel_highlighted?(LookBookHelper::MAX_CAROUSEL_SIZE)).to eq(true)
    end

    it 'should return true when larger than MAX_CAROUSEL_SIZE' do
      expect(carousel_highlighted?(LookBookHelper::MAX_CAROUSEL_SIZE + 1)).to eq(true)
    end

    it 'should return false when smaller than MAX_CAROUSEL_SIZE' do
      expect(carousel_highlighted?(LookBookHelper::MAX_CAROUSEL_SIZE - 1)).to eq(false)
    end
  end
end
