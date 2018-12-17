require 'rails_helper'

describe 'programs/_list_item.html.erb' do
  it 'should render' do
    expect{ render partial: 'programs/list_item', locals: { slug: Program::GRADUATION_SLUG, link: Program::SENIOR_LINK, button_text: 'View' } }.not_to raise_error
  end
end
