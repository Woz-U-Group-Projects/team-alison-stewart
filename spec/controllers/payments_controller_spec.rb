require 'rails_helper'

describe PaymentsController, type: :controller do
  render_views

  describe '#new' do
    before(:each) do
      @school = FactoryGirl.create(:school, code: 'TEST')
      @time_trade_meta_data = FactoryGirl.create(:time_trade_meta_data, school: @school, school_code: @school.code)
      @time_trade_appointment_type = FactoryGirl.create(:time_trade_appointment_type, time_trade_meta_data: @time_trade_meta_data, photo_type: Sitting::SITTING_TYPE_GRAD)

      @customer = FactoryGirl.create(:customer, ID: "TEST#{Utils.photography_year}-123")
      @booking = FactoryGirl.create(:booking, customer: @customer, sitting_type: Sitting::SITTING_TYPE_GRAD)

      @params = {
        school_id: @school.code,
        booking_id: @booking.id
      }
    end

    it 'should return 200' do
      get :new, @params

      expect(response.status).to eq(200)
    end

    it 'should render the new template' do
      get :new, @params

      expect(response).to render_template('new')
    end

    it 'should 404 when school does not exist' do
      @params[:school_id] = 'wrong'

      get :new, @params

      expect(response.status).to eq(404)
    end

    it 'should 404 when time trade meta data does not exist' do
      @time_trade_meta_data.destroy

      get :new, @params

      expect(response.status).to eq(404)
    end

    it 'should 404 when time trade appointment type does not exist' do
      @time_trade_appointment_type.destroy

      get :new, @params

      expect(response.status).to eq(404)
    end
  end

  describe '#create' do
    before(:each) do
      @school = FactoryGirl.create(:school, code: 'TEST')
      @time_trade_meta_data = FactoryGirl.create(:time_trade_meta_data, school: @school, school_code: @school.code)
      @time_trade_appointment_type = FactoryGirl.create(:time_trade_appointment_type, time_trade_meta_data: @time_trade_meta_data, photo_type: Sitting::SITTING_TYPE_GRAD)

      @customer = FactoryGirl.create(:customer, ID: "TEST#{Utils.photography_year}-123")
      @booking = FactoryGirl.create(:booking, customer: @customer, sitting_type: Sitting::SITTING_TYPE_GRAD)

      @credit_card = {
        first_name: 'Test',
        last_name: 'McTest',
        number: '4111 1111 1111 1111',
        brand: 'visa',
        verification_value: '123',
        month: '01',
        year: Date.today.year + 5
      }

      @params = {
        school_id: @school.code,
        booking_id: @booking.id,
        payment: {
          credit_card: @credit_card
        }
      }
    end

    it 'should redirect to confirmation' do
      post :create, @params

      expect(response).to redirect_to(confirmation_school_booking_path(@school.code, @booking))
    end

    it 'should put booking into booked state' do
      post :create, @params

      expect(@booking.reload.booked?).to eq(true)
    end

    it 'should upload customer' do
      expect(XmlUploaders::Customer).to receive(:enqueue_from_booking)

      post :create, @params
    end

    it 'should create a new payment' do
      expect{ post :create, @params }.to change{ Payment.count }.by(1)
    end

    it 'should create a new gateway transaction' do
      expect{ post :create, @params }.to change{ GatewayTransaction.count }.by(1)
    end

    it 'should redirect to time trade when not paying' do
      @params[:booking][:delayed_payment] = '1'

      post :create, @params

      expect(response.status).to eq(302)
    end

    it 'should put booking into booked state when not paying' do
      @params[:booking][:delayed_payment] = '1'

      post :create, @params

      expect(@booking.reload.booked?).to eq(true)
    end

    it 'should upload customer when not paying' do
      @params[:booking][:delayed_payment] = '1'

      expect(XmlUploaders::Customer).to receive(:enqueue_from_booking)

      post :create, @params
    end

    it 'should 404 if already booked' do
      @booking.book!

      post :create, @params

      expect(response.status).to eq(404)
    end

    it 'should fail with bad credit card' do
      @params[:payment][:credit_card][:number] = '4111 1111 1111 1112'

      post :create, @params

      expect(response.status).to eq(422)
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
  end
end
