class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]
  has_many :goals

  def self.from_omniauth(auth)
    where(provider: auth.try(:[], :provider), uid: auth.try(:[], :uid)).first_or_create do |user|
      user.password = Devise.friendly_token[0,20]
      user.email = auth[:info][:email]
      user.name = auth[:info][:name]
    end
  end

end
