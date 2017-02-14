class CreateFacebookUserService
  attr_reader :omniauth_data, :listener

  def initialize(omniauth_data, listener)
    @omniauth_data = omniauth_data
    @listener = listener
  end

  def perform
    user = CreateUserFromOAuthService.perform(omniauth_data)

    if user.persisted?
      listener.sign_in_and_redirect user
      listener.send(:set_flash_message, :notice, :success, kind: 'Facebook')
    else
      listener.send(:set_flash_message, :notice, :failure, kind: 'Facebook')
      listener.failure
    end
  end

end
