class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    omniauth_data = request.env['omniauth.auth']

    use_case_request = CreateFacebookUserRequest.new(
        provider: omniauth_data[:provider],
        uid: omniauth_data[:uid],
        random_token: Devise.friendly_token[0, 20],
        email: omniauth_data[:info][:email],
        name: omniauth_data[:info][:name]
    )

    @service = CreateFacebookUser.new(use_case_request, self)
    @service.perform
  end

  def handle_failure
    set_flash_message :notice, :failure, kind: 'Facebook'

    redirect_to root_path
  end

  def handle_success(persisted_user)
    user = UserConverter.convert_to_active_record(user_entity: persisted_user)
    user.reload

    sign_in_and_redirect user
    set_flash_message(:notice, :success, kind: 'Facebook')
  end
end