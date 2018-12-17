require 'rails_helper'

describe ServicesController, type: :controller do
  render_views

  describe '#show' do
    before(:each) do
      @service = FactoryGirl.create(:service)

      @params = { id: @service.id }
    end

    it 'should return 200' do
      get :show, @params

      expect(response.status).to eq(200)
    end

    it 'should render the show template' do
      get :show, @params

      expect(response).to render_template('show')
    end

    it 'should 404 when look book does not exist' do
      @params[:id] = 'wrong'

      get :show, @params

      expect(response.status).to eq(404)
    end
  end
end
