module SessionHelpers
  def sign_in_as(user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  def sign_out
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(nil)
  end
end
