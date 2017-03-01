class UserConverter
  def self.convert_to_active_record(user_entity:)
    User.new(
        id: user_entity.id,
        provider: user_entity.provider,
        uid: user_entity.uid,
        password: user_entity.password,
        email: user_entity.email,
        name: user_entity.name
    )
  end

  def self.convert_to_entity(active_record_user:)
    UserEntity.new(
      id: active_record_user.id,
      provider: active_record_user.provider,
      uid: active_record_user.uid,
      password: active_record_user.password,
      email: active_record_user.email,
      name: active_record_user.name
    )
  end
end