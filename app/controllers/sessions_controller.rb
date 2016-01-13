class SessionsController < Devise::SessionsController
  def callback
    auth # Do what you want with the auth hash!
  end

  def after_signin_path_for(resource)
    root_path
  end

  def auth; request.env['omniauth.auth'] end
end