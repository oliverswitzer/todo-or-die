class FriendRepository
  def self.find(token:)
    graph = Koala::Facebook::API.new(token)

    graph.get_connections('me', 'taggable_friends').map do |friend|
      convert_to_entity(friend)
    end
  end

  private

  def self.convert_to_entity(friend_hash)
    FriendEntity.new(
        name: friend_hash['name'],
        image_url: friend_hash.try(:[], 'picture').try(:[], 'data').try(:[], 'url').maybe,
        id: friend_hash['id']
    )
  end
end