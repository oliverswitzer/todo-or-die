class FriendEntity
  attr_reader :name, :image_url, :id

  def initialize(name:nil, image_url:nil, id:nil)
    @name = name
    @image_url = image_url
    @id = id
  end
end
