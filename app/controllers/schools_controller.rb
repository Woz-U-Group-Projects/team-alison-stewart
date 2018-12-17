class SchoolsController < ApplicationController
  # Before filters
  before_filter :fetch_school, only: [:show]

  # Scopes
  has_scope :search

  def index
    render json: apply_scopes(School).all
  end

  def show
  end

  def book
  end

  def find
    @school = School.find_by_name(params.dig(:school, :name))

    return redirect_to school_path(@school.code) if @school

    @schools = School.search(params.dig(:school, :name))
  end

  private

  def fetch_school
    @school = School.find_by_code!(params[:id])
  rescue ActiveRecord::RecordNotFound
    return render_error(404)
  end
end
