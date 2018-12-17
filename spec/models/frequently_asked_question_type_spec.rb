require 'rails_helper'

RSpec.describe FrequentlyAskedQuestionType, type: :model do
  before do
    @frequently_asked_question_type = FactoryGirl.create(:frequently_asked_question_type)
  end

  subject{ @frequently_asked_question_type }

  # Associations
  it { is_expected.to have_many(:frequently_asked_questions).dependent(:destroy) }

  # Validations
  it { is_expected.to validate_presence_of(:name) }
end
