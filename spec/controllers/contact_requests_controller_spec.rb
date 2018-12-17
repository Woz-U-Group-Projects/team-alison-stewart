require 'rails_helper'

describe ContactRequestsController, type: :controller do
  render_views

  describe '#create' do
    before(:each) do
      request.env['HTTP_REFERER'] = 'back'

      @params = {
        contact_request: {
          to_emails:  'test@test.com',
          from_email: 'test@test.com',
          subject:    'subject',
          body:       'body'
        }
      }
    end

    it 'should create a registration' do
      expect{ post :create, @params }.to change{ ContactRequest.count }.by(1)
    end

    it 'should return 302' do
      post :create, @params

      expect(response.status).to eq(302)
    end

    it 'should return 302 when failed' do
      @params[:contact_request][:to_emails] = nil

      post :create, @params

      expect(response.status).to eq(302)
    end
  end
end
