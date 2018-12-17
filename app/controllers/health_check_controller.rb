class HealthCheckController < ApplicationController
  def index
    render text: 'ok'
  end
end
