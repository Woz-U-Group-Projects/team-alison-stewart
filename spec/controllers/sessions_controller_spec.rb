require 'rails_helper'

describe SessionsController, type: :controller do
  render_views

  describe '#new' do
    it 'should render the new template' do
      get :new

      expect(response).to render_template('new')
    end

    it 'should redirect if logged in' do
      sign_in_as(FactoryGirl.create(:user))

      get :new

      expect(response).to redirect_to(admin_root_path)
    end
  end

  describe '#create' do
    before(:each) do
      @user = FactoryGirl.create(:user, email: 'test@test.com')

      @params = {
        user: {
          email: 'test@test.com',
          password: 'password'
        }
      }
    end

    it 'should return 302' do
      post :create, @params

      expect(response.status).to eq(302)
    end

    it 'should redirect to admin panel' do
      post :create, @params

      expect(response).to redirect_to(admin_root_path)
    end

    it 'should 422 when failed' do
      @params[:user][:password] = 'a'

      post :create, @params

      expect(response.status).to eq(422)
    end

    it 'should render new template when failed' do
      @params[:user][:password] = 'a'

      post :create, @params

      expect(response).to render_template('new')
    end

    it 'should fail when user is not enabled' do
      @user.enabled = false
      @user.save

      post :create, @params

      expect(response.status).to eq(422)
    end
  end

  describe '#show' do
    before(:each) do
      @user = FactoryGirl.create(:user, email: 'test@test.com')

      sign_in_as(@user)
    end

    it 'should return 302' do
      delete :destroy

      expect(response.status).to eq(302)
    end

    it 'should redirect to root' do
      delete :destroy

      expect(response).to redirect_to(root_path)
    end

    it 'should forget the current user' do
      delete :destroy

      expect(@user.reload.remember_token_expires_at).to be_nil
      expect(@user.remember_token).to be_nil
    end

    it 'should redirect to new session when not authenticated' do
      sign_out

      delete :destroy

      expect(response).to redirect_to(new_session_path)
    end
  end

  describe '#destroy' do
    before(:each) do
      @user = FactoryGirl.create(:user, email: 'test@test.com')

      sign_in_as(@user)
    end

    it 'should return 302' do
      delete :destroy

      expect(response.status).to eq(302)
    end

    it 'should redirect to root' do
      delete :destroy

      expect(response).to redirect_to(root_path)
    end

    it 'should forget the current user' do
      delete :destroy

      expect(@user.reload.remember_token_expires_at).to be_nil
      expect(@user.remember_token).to be_nil
    end

    it 'should redirect to new session when not authenticated' do
      sign_out

      delete :destroy

      expect(response).to redirect_to(new_session_path)
    end
  end
end
