require 'rails_helper'

describe HealthCheckController, type: :controller do
  render_views

  describe '#index' do
    it 'should return 200' do
      get :index

      expect(response.status).to eq(200)
    end
  end
end
