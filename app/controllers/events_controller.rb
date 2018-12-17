class EventsController < ApplicationController
  # Before filters
  before_filter :fetch_school, only: [:index]
  before_filter :ensure_not_university, only: [:index]

  def index
  end

  private

  def fetch_school
    @school = School.find_by_code!(params[:school_id])
  rescue ActiveRecord::RecordNotFound
    return render_error(404)
  end

  def ensure_not_university
    return redirect_to school_path(@school.code) if @school.schools.count > 0
  end
end
