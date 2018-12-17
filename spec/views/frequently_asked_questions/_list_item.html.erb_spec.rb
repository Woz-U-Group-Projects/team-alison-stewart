require 'rails_helper'

describe 'frequently_asked_questions/_list_item.html.erb' do
  before(:each) do
    @faq = FactoryGirl.create(:frequently_asked_question)
  end

  it 'should render' do
    expect{ render partial: 'frequently_asked_questions/list_item', locals: { frequently_asked_question: @faq } }.not_to raise_error
  end
end
