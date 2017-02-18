class UserRepository
  def self.find_or_create(user_entity:)
    user = User.where(
        provider: user_entity.provider,
        uid: user_entity.uid
    ).first_or_create do |user|
      user.password = user_entity.password
      user.email = user_entity.email
      user.name = user_entity.name
    end

    user_entity.id = user.id

    user.persisted?
  end
end