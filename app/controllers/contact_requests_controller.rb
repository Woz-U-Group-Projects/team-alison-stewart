class ContactRequestsController < ApplicationController
  def create
    @contact_request = ContactRequest.new(contact_request_params)

    if @contact_request.save
      flash[:notice] = 'Request sent!'
      redirect_to :back
    else
      flash[:error] = 'Cannot send request. Please try again.'
      redirect_to :back
    end
  end

  private

  def contact_request_params
    params.require(:contact_request).permit(
      :to_emails,
      :from_email,
      :subject,
      :body
    )
  end
end
