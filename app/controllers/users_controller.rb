class UsersController < ApplicationController
  def unsubscribe
    if user = User.read_access_token(params[:signature])
      user.subscriptions.destroy_all
      #render text: "You have been unsubscribed"
    else
      render text: "Invalid Link"
    end
  end
end
