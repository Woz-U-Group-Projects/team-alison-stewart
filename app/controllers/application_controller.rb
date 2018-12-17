require 'authentication'

class ApplicationController < ActionController::Base
  include Authentication

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Before filters
  before_filter :set_seo_tags

  private

  def set_seo_tags
    set_meta_tags title:        'Artona: Since 1909',
                  description:  '',
                  keywords:     %w[Artona Group ArtonaGroup Photography],
                  og:  {
                    title:        'Artona: Since 1909',
                    type:         'website',
                    url:          'http://artona.com',
                    image:        ActionController::Base.helpers.image_path('favicons/favicon-96x96.png'),
                    description:  ''
                  },
                  twitter: {
                    card:         'summary',
                    url:          'http://artona.com',
                    title:        'Artona: Since 1909',
                    image:        ActionController::Base.helpers.image_path('favicons/favicon-96x96.png'),
                    description:  ''
                  }
  end

  def render_error(code, message = nil)
    @status_code = code
    @message = message

    render 'errors/show', status: code
  end

  def ensure_authenticated
    login_required
  end
end

