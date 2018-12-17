class ServicesController < ApplicationController
  # Before filters
  before_filter :fetch_service, only: [:show]

  def show
  end

  private

  def fetch_service
    @service = Service.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    return render_error(404)
  end
end
