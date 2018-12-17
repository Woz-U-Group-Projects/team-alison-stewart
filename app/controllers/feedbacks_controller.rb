class FeedbacksController < ApplicationController

  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(feedback_params)

    if @feedback.save
      flash[:notice] = 'Feedback sent!'
      redirect_to thank_you_feedbacks_path
    else
      flash[:error] = 'Cannot send feedback. Please try again.'
      render :new
    end
  end

  def thank_you
  end

  private

  def feedback_params
    params.require(:feedback).permit(
      :from_email,
      :subject,
      :body
    )
  end
end
