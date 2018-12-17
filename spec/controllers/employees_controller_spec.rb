require 'rails_helper'

describe EmployeesController, type: :controller do
  render_views

  describe '#index' do
    it 'should return 200' do
      get :index

      expect(response.status).to eq(200)
    end

    it 'should render the index template' do
      get :index

      expect(response).to render_template('index')
    end
  end
end
