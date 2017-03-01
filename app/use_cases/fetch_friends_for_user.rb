class FetchFriendsForUser
  def initialize(friends_request, listener)
    @fetch_friends_request = friends_request
    @listener = listener
  end

  def perform
    fb_token = @fetch_friends_request.facebook_token

    if fb_token.blank?
      @listener.handle_failure('No facebook token for user present')
    else
      @listener.handle_success(FriendRepository.find(token: fb_token.get))
    end
  end
end