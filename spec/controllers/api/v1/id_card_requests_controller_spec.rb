require 'rails_helper'

describe Api::V1::IdCardRequestsController, type: :controller do
  render_views

  before(:each) do
    @id_card_request = FactoryGirl.create(:id_card_request)
  end

  describe '#index' do
    it 'should return success' do
      get :index

      expect(response.status).to eq(200)
    end

    it 'should return an array of ID card requests' do
      get :index

      expect(json_response['data'][0]['id']).to eq(@id_card_request.id.to_s)
    end

    it 'should set the header' do
      get :index

      ['Total', 'Per-Page'].each do |key|
        expect(response.header[key]).to_not be_nil
      end
    end

    it 'should scope to a state' do
      @id_card_request2 = FactoryGirl.create(:id_card_request)
      @id_card_request2.request!

      get :index, state: 'pending'

      expect(json_response['data'][0]['id']).to eq(@id_card_request.id.to_s)
      expect(json_response['data'].length).to eq(1)
    end
  end

  describe '#update' do
    before(:each) do
      @params = { id: @id_card_request.id, id_card_request: { state: 'processed' } }
    end

    it 'should return success' do
      patch :update, @params

      expect(response.status).to eq(200)
    end

    it 'should update the ID card request' do
      patch :update, @params

      expect(@id_card_request.reload.processed?).to eq(true)
    end

    it 'should return the ID card request' do
      patch :update, @params

      expect(json_response['data']['id']).to eq(@id_card_request.id.to_s)
    end

    it 'should 404 when not found' do
      @params[:id] = 'wrong'

      patch :update, @params

      expect(response.status).to eq(404)
    end
  end
end
