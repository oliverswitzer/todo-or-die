class UserEntity
  attr_reader :password, :email, :name, :provider, :uid
  attr_accessor :id

  def initialize(id: nil, password: nil, email: nil, name: nil, provider: nil, uid: nil)
    @id = id
    @password = password
    @email = email
    @name = name
    @provider = provider
    @uid = uid
  end
end