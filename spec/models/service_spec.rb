require 'rails_helper'

RSpec.describe Service, type: :model do
  before do
    @service = FactoryGirl.create(:service)
  end

  subject{ @service }

  # Associations
  it { is_expected.to have_many(:photos).dependent(:destroy) }
  it { is_expected.to have_many(:features).dependent(:destroy) }
  it { is_expected.to have_many(:look_books).dependent(:destroy) }

  # Validations
  it { is_expected.to validate_presence_of(:title) }

  it 'should not allow bad email in contact emails' do
    @service.contact_emails = 'test@test.org,blah'

    expect(@service).not_to be_valid
  end
end
