class ProgramsController < ApplicationController
  # Before filters
  before_filter :fetch_program, only: [:show]
  before_filter :fetch_demo_videos, only: [:show]

  def show
  end

  private

  def fetch_program
    @school   = School.find_by_code!(params[:school_id])
    @program  = Program.find(params[:id])

    return render_error(404) unless @program
  rescue ActiveRecord::RecordNotFound
    return render_error(404)
  end

  def fetch_demo_videos
    ids = @school.events.collect(&:event_type_id).uniq

    @demo_videos = []

    case @program.slug
    when Program::SCHOOL_PHOTO_SLUG
      @demo_videos = DemoVideo.where(event_type_id: ids)
    when Program::GRADUATION_SLUG, Program::CONVOCATION_SLUG
      @demo_videos = DemoVideo.where(event_type_id: ids, grad_program_code: @school.grad_program_code)

      if @demo_videos.count <= 0
        @demo_videos = DemoVideo.where(event_type_id: ids)
      end
    end
  end
end
