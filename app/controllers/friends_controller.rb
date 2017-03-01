class FriendsController < ApplicationController
  def index
    use_case_request = FetchFriendsForUserRequest.new(facebook_token: session[:fb_token].maybe)

    use_case = FetchFriendsForUser.new(use_case_request, self)
    use_case.perform
  end

  def handle_success(friends)
    @friends = friends
  end

  def handle_failure(message)
    flash[:error] = message
  end
end
