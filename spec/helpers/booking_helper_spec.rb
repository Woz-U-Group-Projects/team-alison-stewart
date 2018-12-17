require 'rails_helper'

describe BookingHelper, type: :helper do
  describe '#booking_progress_bar_items' do
    before(:each) do
      @booking = FactoryGirl.create(:booking)
    end

    it 'should return an array' do
      expect(booking_progress_bar_items(@booking)).to be_a(Array)
    end
  end
end
