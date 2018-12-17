require 'rails_helper'

describe 'schools/find.html.erb' do
  context 'when finding school' do
    before(:each) do
      @schools = [FactoryGirl.create(:school)]

      allow(view).to receive(:params).and_return({
        school: {
          name: @schools.first.name[0..3]
        }
      })
    end

    it 'should render' do
      expect{ render }.not_to raise_error
    end

    it 'should show search results' do
      render

      expect(rendered).to have_content('We could not find the school you requested.')
    end
  end

  context 'when not finding school' do
    before(:each) do
      allow(view).to receive(:params).and_return({})
    end

    it 'should render' do
      expect{ render }.not_to raise_error
    end

    it 'should not show search results' do
      render

      expect(rendered).not_to have_content('We could not find the school you requested.')
    end
  end
end
