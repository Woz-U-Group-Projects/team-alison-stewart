require 'rails_helper'

describe RootController, type: :controller do
  render_views

  describe '#show' do
    it 'should render the show template' do
      get :show

      expect(response).to render_template('show')
    end
  end
end
