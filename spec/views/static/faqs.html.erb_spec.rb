require 'rails_helper'

describe 'static/faqs.html.erb' do
  before(:each) do
    @faq = FactoryGirl.create(:frequently_asked_question)
  end

  it 'should render' do
    expect{ render }.not_to raise_error
  end

  it 'should render FAQ types' do
    @faq.frequently_asked_question_type = FactoryGirl.create(:frequently_asked_question_type, name: 'student')
    @faq.save

    render

    expect(rendered).to have_content('Student')
    expect(rendered).to have_content(@faq.question)
  end
end
