require 'rails_helper'

describe 'layouts/application.html.erb' do
  before do
      allow(view).to receive(:user_signed_in?).and_return(true)
  end
  
  it 'should render' do
    expect{ render }.not_to raise_error
  end

  it 'should render favicons' do
    render

    expect(rendered).to render_template(partial: 'common/_favicons')
  end

  it 'should render header' do
    render

    expect(rendered).to render_template(partial: 'common/_header')
  end

  it 'should render footer' do
    render

    expect(rendered).to render_template(partial: 'common/_footer')
  end
end
