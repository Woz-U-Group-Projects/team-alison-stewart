require 'rails_helper'

RSpec.describe Photo, type: :model do
  before do
    @photo = FactoryGirl.create(:photo)
  end

  subject{ @photo }

  # Associations
  it { is_expected.to belong_to(:owner) }
end
