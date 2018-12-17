require 'rails_helper'

RSpec.describe IdCardRequest, type: :model do
  before do
    @id_card_request = FactoryGirl.create(:id_card_request)
  end

  subject{ @id_card_request }

  # Associations
  it { is_expected.to belong_to(:id_card_template) }
  it { is_expected.to belong_to(:school) }
  it { is_expected.to have_many(:nodes).dependent(:destroy) }
  it { is_expected.to have_many(:comments).dependent(:destroy) }

  # Validations
  it { is_expected.to validate_presence_of(:id_card_template) }
  it { is_expected.to validate_presence_of(:school) }
  it { is_expected.to validate_presence_of(:attention_of) }
  it { is_expected.to validate_presence_of(:attention_of_email) }

  it 'should not allow duplicate requests' do
    @id_card_request2 = FactoryGirl.build(:id_card_request, school: @id_card_request.school, student_number: @id_card_request.student_number)

    expect(@id_card_request2.valid?).to eq(false)
  end

  it 'should allow duplicate requests once past rendered' do
    @id_card_request.state = 'processed'
    @id_card_request.save

    @id_card_request2 = FactoryGirl.build(:id_card_request, school: @id_card_request.school, student_number: @id_card_request.student_number)

    expect(@id_card_request2.valid?).to eq(true)
  end
end
