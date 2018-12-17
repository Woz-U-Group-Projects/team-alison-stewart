class SessionsController < ApplicationController
  # Before filters
  before_filter :login_required, only: [:show, :destroy]
  before_filter :check_if_logged_in, only: [:new, :create]

  def new
  end

  def show
    self.current_user.forget_me

    cookies.delete :auth_token
    reset_session

    flash[:notice] = 'You have been logged out.'
    redirect_to root_path
  end

  def create
    user = User.authenticate(params.dig(:user, :email), params.dig(:user, :password))

    if user == nil
      failed_login('Your email or password is incorrect.')
    elsif user.enabled == false
      failed_login('Your account has been disabled.')
    else
      self.current_user = user

      flash[:notice] = 'Logged in successfully'
      redirect_back_or_default admin_root_path
    end
  end

  def destroy
    self.current_user.forget_me

    cookies.delete :auth_token
    reset_session

    flash[:notice] = 'You have been logged out.'
    redirect_to root_path
  end

  private

  def check_if_logged_in
    return redirect_to admin_root_path if current_user
  end

  def failed_login(message)
    flash[:error] = message
    render action: 'new', status: 422
  end
end
