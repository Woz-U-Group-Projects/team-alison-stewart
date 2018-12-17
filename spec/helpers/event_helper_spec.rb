require 'rails_helper'

describe EventHelper, type: :helper do
  describe '#event_icon' do
    before(:each) do
      @event = FactoryGirl.create(:event)
    end

    it 'should return string' do
      expect(event_icon(@event)).to be_a(String)
    end
  end
end
