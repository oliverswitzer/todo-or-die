class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    omniauth_data = request.env['omniauth.auth']

    @service = CreateFacebookUserService.new(omniauth_data, self)
    @service.perform
  end

  def failure
    redirect_to root_path
  end
end