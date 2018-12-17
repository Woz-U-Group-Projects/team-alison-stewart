require 'rails_helper'

describe 'errors/show.html.erb' do
  it 'should display the error message' do
    render

    expect(rendered).to have_content('Whoops! A error was caused by your request.')
    expect(rendered).to have_content('Please make sure you are visiting the correct page, or try again.')
  end

  it 'should display apology' do
    render

    expect(rendered).to have_content('Whoops!')
  end

  it 'should display the error code' do
    @status_code = '404'

    render

    expect(rendered).to have_content('404')
  end

  it 'should display the action text' do
    render

    expect(rendered).to have_content('Please make sure you are visiting the correct page, or try again.')
  end

  it 'should display custom message when present' do
    @message = 'Test message'

    render

    expect(rendered).to have_content(@message)
  end
end
