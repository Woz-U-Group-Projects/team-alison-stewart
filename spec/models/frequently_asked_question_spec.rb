require 'rails_helper'

RSpec.describe FrequentlyAskedQuestion, type: :model do
  before do
    @frequently_asked_question = FactoryGirl.create(:frequently_asked_question)
  end

  subject{ @frequently_asked_question }

  # Associations
  it { is_expected.to belong_to(:frequently_asked_question_type) }

  # Validations
  it { is_expected.to validate_presence_of(:question) }
  it { is_expected.to validate_presence_of(:answer) }
  it { is_expected.to validate_presence_of(:frequently_asked_question_type) }

  # Scopes
  describe 'frequently_asked_question_type' do
    it 'should return the FAQs for the question type' do
      expect(FrequentlyAskedQuestion.frequently_asked_question_type(@frequently_asked_question.frequently_asked_question_type).map(&:id)).to eq([@frequently_asked_question.id])
    end
  end
end
