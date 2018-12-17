require 'rails_helper'

describe ProgramsController, type: :controller do
  render_views

  describe '#show' do
    before(:each) do
      @school = FactoryGirl.create(:school)
      @program = FactoryGirl.create(:program)

      @params = {
        school_id: @school.code,
        id: @program.slug
      }
    end

    it 'should return 200' do
      get :show, @params

      expect(response.status).to eq(200)
    end

    it 'should render the show template' do
      get :show, @params

      expect(response).to render_template('show')
    end

    it 'should 404 when school does not exist' do
      @params[:school_id] = 'wrong'

      get :show, @params

      expect(response.status).to eq(404)
    end

    it 'should 404 when program does not exist' do
      @params[:id] = 'wrong'

      get :show, @params

      expect(response.status).to eq(404)
    end
  end
end
