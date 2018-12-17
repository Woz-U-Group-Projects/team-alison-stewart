require 'rails_helper'

describe BookingsController, type: :controller do
  render_views

  describe '#create' do
    before(:each) do
      @school = FactoryGirl.create(:school, code: 'TEST')
      @time_trade_meta_data = FactoryGirl.create(:time_trade_meta_data, school: @school, school_code: @school.code)
      @time_trade_appointment_type = FactoryGirl.create(:time_trade_appointment_type, time_trade_meta_data: @time_trade_meta_data, photo_type: Sitting::SITTING_TYPE_GRAD)

      @customer = FactoryGirl.create(:customer, ID: "TEST#{Utils.photography_year}-123")
      @user_defined_field = FactoryGirl.create(:user_defined_field, ID: UserDefinedField::FIELD_MAPPINGS[:student_number][:name], STRING_VAL: '123456', DOCUMENT_ID: @customer.id)

      @params = {
        school_id: @school.code,
        booking: {
          student_number: '123456',
          graduation_year: Utils.photography_year,
          sitting_type: Sitting::SITTING_TYPE_GRAD
        }
      }
    end

    it 'should return 302' do
      post :create, @params

      expect(response.status).to eq(302)
    end

    it 'should create the booking' do
      expect{ post :create, @params }.to change{ Booking.count }.by(1)
    end

    it 'should create the booking when student ID does not exist' do
      @user_defined_field.destroy

      expect{ post :create, @params }.to change{ Booking.count }.by(1)
    end

    it 'should 404 when school does not exist' do
      @params[:school_id] = 'wrong'

      post :create, @params

      expect(response.status).to eq(404)
    end

    it 'should 404 when time trade meta data does not exist' do
      @time_trade_meta_data.destroy

      post :create, @params

      expect(response.status).to eq(404)
    end

    it 'should 404 when time trade appointment type does not exist' do
      @time_trade_appointment_type.destroy

      post :create, @params

      expect(response.status).to eq(404)
    end

    it 'should 404 when customer does not exist' do
      @customer.destroy

      post :create, @params

      expect(response.status).to eq(404)
    end
  end

  describe '#edit' do
    before(:each) do
      @school = FactoryGirl.create(:school, code: 'TEST')
      @time_trade_meta_data = FactoryGirl.create(:time_trade_meta_data, school: @school, school_code: @school.code)
      @time_trade_appointment_type = FactoryGirl.create(:time_trade_appointment_type, time_trade_meta_data: @time_trade_meta_data, photo_type: Sitting::SITTING_TYPE_GRAD)

      @customer = FactoryGirl.create(:customer, ID: "TEST#{Utils.photography_year}-123")
      @booking = FactoryGirl.create(:booking, customer: @customer)

      @params = {
        school_id: @school.code,
        id: @booking.id,
        booking: {
          sitting_type: Sitting::SITTING_TYPE_GRAD
        }
      }
    end

    it 'should return 200' do
      get :edit, @params

      expect(response.status).to eq(200)
    end

    it 'should render the edit template' do
      get :edit, @params

      expect(response).to render_template('edit')
    end

    it 'should 404 when school does not exist' do
      @params[:school_id] = 'wrong'

      get :edit, @params

      expect(response.status).to eq(404)
    end

    it 'should 404 when time trade meta data does not exist' do
      @time_trade_meta_data.destroy

      get :edit, @params

      expect(response.status).to eq(404)
    end

    it 'should 404 when time trade appointment type does not exist' do
      @time_trade_appointment_type.destroy

      get :edit, @params

      expect(response.status).to eq(404)
    end
  end

  describe '#update' do
    before(:each) do
      @school = FactoryGirl.create(:school, code: 'TEST')
      @time_trade_meta_data = FactoryGirl.create(:time_trade_meta_data, school: @school, school_code: @school.code)
      @time_trade_appointment_type = FactoryGirl.create(:time_trade_appointment_type, time_trade_meta_data: @time_trade_meta_data, photo_type: Sitting::SITTING_TYPE_GRAD)

      @customer = FactoryGirl.create(:customer, ID: "TEST#{Utils.photography_year}-123")
      @booking = FactoryGirl.create(:booking, customer: @customer)

      @params = {
        school_id: @school.code,
        id: @booking.id,
        booking: {
          email_parent: 'parent@test.com',
          email_student: 'student@test.com',
          first_name: 'First',
          last_name: 'Last',
          gender: 'male',
          height_ft: 5,
          height_in: 9,
          graduation_year: Utils.photography_year,
          phone_parent: '1235551234',
          phone_student: '1235551234',
          sitting_type: Sitting::SITTING_TYPE_GRAD,
          student_number: '123456',
          address_attributes: {
            owner_type: 'Booking',
            owner_id: @booking.id,
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

    it 'should redirect to time trade' do
      patch :update, @params

      expect(response.status).to eq(302)
    end

    it 'should put booking into booked state not grad sitting' do
      @time_trade_appointment_type.photo_type = Sitting::SITTING_TYPE_GROUP
      @time_trade_appointment_type.save

      @params[:booking][:sitting_type] = Sitting::SITTING_TYPE_GROUP

      patch :update, @params

      expect(@booking.reload.booked?).to eq(true)
    end

    it 'should upload customer not grad sitting' do
      @time_trade_appointment_type.photo_type = Sitting::SITTING_TYPE_GROUP
      @time_trade_appointment_type.save

      @params[:booking][:sitting_type] = Sitting::SITTING_TYPE_GROUP

      expect(XmlUploaders::Customer).to receive(:enqueue_from_booking)

      patch :update, @params
    end

    it 'should 404 if already booked' do
      @booking.book!

      patch :update, @params

      expect(response.status).to eq(404)
    end

    it 'should fail with bad address' do
      @params[:booking][:address_attributes][:address1] = nil

      patch :update, @params

      expect(response.status).to eq(422)
    end

    it 'should 404 when school does not exist' do
      @params[:school_id] = 'wrong'

      patch :update, @params

      expect(response.status).to eq(404)
    end

    it 'should 404 when time trade meta data does not exist' do
      @time_trade_meta_data.destroy

      patch :update, @params

      expect(response.status).to eq(404)
    end

    it 'should 404 when time trade appointment type does not exist' do
      @time_trade_appointment_type.destroy

      patch :update, @params

      expect(response.status).to eq(404)
    end
  end

  describe '#confirmation' do
    before(:each) do
      @school = FactoryGirl.create(:school, code: 'TEST')
      @time_trade_meta_data = FactoryGirl.create(:time_trade_meta_data, school: @school, school_code: @school.code)
      @time_trade_appointment_type = FactoryGirl.create(:time_trade_appointment_type, time_trade_meta_data: @time_trade_meta_data)

      @customer = FactoryGirl.create(:customer, ID: "TEST#{Utils.photography_year}-123")
      @booking = FactoryGirl.create(:booking, customer: @customer, state: 'booked')

      @params = {
        school_id: @school.code,
        graduation_year: Utils.photography_year,
        id: @booking.id
      }
    end

    it 'should return 200' do
      get :confirmation, @params

      expect(response.status).to eq(200)
    end

    it 'should render the confirmation template' do
      get :confirmation, @params

      expect(response).to render_template('confirmation')
    end

    it 'should 404 when school does not exist' do
      @params[:school_id] = 'wrong'

      get :confirmation, @params

      expect(response.status).to eq(404)
    end

    it 'should redirect when not booked' do
      @booking.state = 'pending'
      @booking.save

      get :confirmation, @params

      expect(response).to redirect_to(edit_school_booking_path(@school.code, @booking))
    end
  end

  describe '#thank_you' do
    it 'should return 200' do
      get :thank_you

      expect(response.status).to eq(200)
    end

    it 'should render the thank you template' do
      get :thank_you

      expect(response).to render_template('thank_you')
    end
  end
end
