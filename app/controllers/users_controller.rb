class UsersController < ApplicationController
  # unsubscribe from the mailing
  def unsubscribe
    if user = User.read_access_token(params[:signature])
      user.subscriptions.destroy_all
    else
      render text: "Invalid Link"
    end
  end
end
