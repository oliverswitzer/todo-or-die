class CreateUserFromOAuthService
  def self.perform(omniauth_data)
    return User.where(
        provider: omniauth_data[:provider],
        uid: omniauth_data[:uid]).first_or_create do |user| # Block only executes first time user is created

      user.password = Devise.friendly_token[0, 20]
      user.email = omniauth_data[:info][:email]
      user.name = omniauth_data[:info][:name]
    end
  end
end