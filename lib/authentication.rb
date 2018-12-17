module Authentication
  protected

  def current_user=(new_user)
    session[:user_id] = new_user ? new_user.id : nil
    @current_user = new_user || false
  end

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= (login_from_session || login_from_basic_auth || login_from_cookie) unless @current_user == false
  end

  def authorized?
    logged_in?
  end

  def login_required
    logged_in? || access_denied
  end

  def admin_login_required
    (logged_in? && current_user.is?(:admin)) || access_denied
  end

  def access_denied
    respond_to do |format|
      format.html do
        unless logged_in?
          store_location
          redirect_to new_session_path
        else
          redirect_to root_path
        end
      end

      format.any do
        request_http_basic_authentication 'Web Password'
      end
    end
  end

  def store_location
    session[:return_to] = request.url
  end

  # Redirect to the URI stored by the most recent store_location call or
  # to the passed default.
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)

    session[:return_to] = nil
  end

  # Make #current_user available as ActionView helper methods.
  def self.included(base)
    base.send :helper_method, :current_user
  end

  def login_from_session
    self.current_user = User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def login_from_basic_auth
    authenticate_with_http_basic do |username, password|
      self.current_user = User.authenticate(username, password)
    end
  end

  def login_from_cookie
    user = cookies[:auth_token] && User.find_by(remember_token: cookies[:auth_token])

    if user && user.remember_token?
      cookies[:auth_token] = { value: user.remember_token, expires: user.remember_token_expires_at }

      self.current_user = user
    end
  end
end
