class FetchFriendsForUserRequest
  attr_reader :facebook_token

  def initialize(facebook_token:nil)
    @facebook_token = facebook_token
  end
end