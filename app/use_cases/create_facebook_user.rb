class CreateFacebookUser
  attr_reader :omniauth_data, :listener

  def initialize(omniauth_data, listener)
    @omniauth_data = omniauth_data
    @listener = listener
  end

  def perform
    user = CreateUserFromOAuthService.perform(omniauth_data)

    if user.persisted?
      log_in(user)
    else
      notify_of_failure
    end
  end

  private
    def notify_of_failure
      listener.send(:set_flash_message, :notice, :failure, kind: 'Facebook')
      listener.failure
    end

    def log_in(user)
      listener.sign_in_and_redirect user
      listener.send(:set_flash_message, :notice, :success, kind: 'Facebook')
    end
end
