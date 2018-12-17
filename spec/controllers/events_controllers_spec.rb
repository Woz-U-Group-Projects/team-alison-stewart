require 'rails_helper'

describe EventsController, type: :controller do
  render_views

  describe '#index' do
    before(:each) do
      @school = FactoryGirl.create(:school)

      @params = { school_id: @school.code }
    end

    it 'should return 200' do
      get :index, @params

      expect(response.status).to eq(200)
    end

    it 'should render the index template' do
      get :index, @params

      expect(response).to render_template('index')
    end

    it 'should redirect if the school is a university' do
      @faculty = FactoryGirl.create(:school, parent_school: @school)

      get :index, @params

      expect(response).to redirect_to(school_path(@school.code))
    end

    it 'should 404 when school does not exist' do
      @params[:school_id] = 'wrong'

      get :index, @params

      expect(response.status).to eq(404)
    end
  end
end
