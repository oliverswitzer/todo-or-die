class CreateFacebookUserService
  attr_reader :omniauth_data, :listener

  def initialize(omniauth_data, listener, user_klass)
    @user_klass = user_klass
    @omniauth_data = omniauth_data
    @listener = listener
  end

  def perform
    user = find_or_create_user

    if user.persisted?
      listener.sign_in_and_redirect user
      listener.send(:set_flash_message, :notice, :success, kind: 'Facebook')
    else
      listener.send(:set_flash_message, :notice, :failure, kind: 'Facebook')
      listener.failure
    end
  end

  private

  def find_or_create_user
    return  @user_klass.where(
        provider: omniauth_data[:provider],
        uid: omniauth_data[:uid]).first_or_create do |user|

      user.password = Devise.friendly_token[0, 20]
      user.email = omniauth_data[:info][:email]
      user.name = omniauth_data[:info][:name]
    end
  end
end
