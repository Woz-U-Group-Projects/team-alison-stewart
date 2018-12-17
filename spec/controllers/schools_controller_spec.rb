require 'rails_helper'

describe SchoolsController, type: :controller do
  render_views

  describe '#index' do
    before(:each) do
      @school = FactoryGirl.create(:school)

      @params = {}
    end

    it 'should return 200' do
      get :index, @params

      expect(response.status).to eq(200)
    end

    it 'should render schools by name' do
      @params[:search_by_name] = @school.name

      get :index, @params

      expect(json_response['data'][0]['id']).to eq(@school.id.to_s)
    end
  end

  describe '#show' do
    before(:each) do
      @school = FactoryGirl.create(:school)

      @params = { id: @school.code }
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
      @params[:id] = 'wrong'

      get :show, @params

      expect(response.status).to eq(404)
    end
  end

  describe '#book' do
    it 'should return 200' do
      get :book, @params

      expect(response.status).to eq(200)
    end


    it 'should render book template' do
      get :book

      expect(response).to render_template('book')
    end
  end

  describe '#find' do
    before(:each) do
      @school = FactoryGirl.create(:school)

      @params = {
        school: {
          name: @school.name
        }
      }
    end

    it 'should redirect to school when found' do
      get :find, @params

      expect(response).to redirect_to(school_path(@school.code))
    end

    it 'should render find template' do
      @params[:school][:name] = @school.name[0..2]

      get :find, @params

      expect(response).to render_template('find')
    end
  end
end
