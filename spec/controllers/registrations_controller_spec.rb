require 'rails_helper'

describe RegistrationsController, type: :controller do
  render_views

  describe '#new' do
    before(:each) do
      @school = FactoryGirl.create(:school, registrations_enabled: true)

      @params = { school_id: @school.code }
    end

    it 'should render the new template' do
      get :new, @params

      expect(response).to render_template('new')
    end

    it 'should 404 when school does not exist' do
      get :new, { school_id: 'wrong' }

      expect(response.status).to eq(404)
    end

    it 'should 404 when school does not have registrations enabled' do
      @school.registrations_enabled = false
      @school.save

      get :new, @params

      expect(response.status).to eq(404)
    end
  end

  describe '#create' do
    before(:each) do
      @school = FactoryGirl.create(:school, registrations_enabled: true)

      @params = {
        school_id: @school.code,
        registration: {
          first_name: 'First',
          middle_name: 'Middle',
          last_name: 'Last',
          student_number: '123ABC',
          email_address: 'test@test.com',
          degree: 'Degree',
          address_attributes: {
            address1: '123 Fake St',
            address2: '',
            address3: '',
            city: 'Victoria',
            country: 'CA',
            province: 'BC',
            postal_code: 'V9A4P7'
          }
        }
      }
    end

    it 'should create a registration' do
      expect{ post :create, @params }.to change{ Registration.count }.by(1)
    end

    it 'should return 302' do
      post :create, @params

      expect(response.status).to eq(302)
    end

    it 'should redirect to confirmation page' do
      post :create, @params

      expect(response).to redirect_to(confirmation_school_registrations_path(@school.code))
    end

    it 'should 422 when failed' do
      @params[:registration][:first_name] = nil

      post :create, @params

      expect(response.status).to eq(422)
    end

    it 'should render new template when failed' do
      @params[:registration][:first_name] = nil

      post :create, @params

      expect(response).to render_template('new')
    end
  end

  describe '#confirmation' do
    before(:each) do
      @school = FactoryGirl.create(:school, registrations_enabled: true)

      @params = { school_id: @school.code }
    end

    it 'should render the confirmation template' do
      get :confirmation, @params

      expect(response).to render_template('confirmation')
    end
  end
end
