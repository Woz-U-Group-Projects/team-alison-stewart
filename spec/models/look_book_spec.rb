require 'rails_helper'

RSpec.describe LookBook, type: :model do
  before do
    @look_book = FactoryGirl.create(:look_book)
  end

  subject{ @look_book }

  # Associations
  it { is_expected.to belong_to(:service) }
  it { is_expected.to have_many(:photos) }

  # Validations
  it { is_expected.to validate_presence_of(:service) }
end
