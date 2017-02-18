
class CreateFacebookUserRequest
  attr_reader :provider, :random_token, :email, :name, :uid

  # TODO: Make all of these fields optional /w this article https://robots.thoughtbot.com/if-you-gaze-into-nil-nil-gazes-also-into-you
  def initialize(provider:nil, random_token:nil, email:nil, name:nil, uid:nil)
    @provider = provider
    @random_token = random_token
    @email = email
    @name = name
    @uid = uid
  end
end