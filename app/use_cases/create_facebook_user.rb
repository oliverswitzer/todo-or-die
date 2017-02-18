class CreateFacebookUser
  attr_reader :create_user_request, :listener

  def initialize(create_user_request, listener)
    @create_user_request = create_user_request
    @listener = listener
  end

  def perform
    user_entity = UserEntity.new(
        password: create_user_request.random_token,
        email: create_user_request.email,
        name: create_user_request.name,
        provider: create_user_request.provider,
        uid: create_user_request.uid
    )

    if UserRepository.find_or_create(user_entity: user_entity)
      listener.handle_success(user_entity)
    else
      listener.handle_failure
    end
  end
end
