require 'rails_helper'

describe FriendRepository do
  TAGGABLE_FRIENDS_FIXTURE = [{
      'id' => 'some long alphanumeric number',
      'name' => 'Joe Boggs',
      'picture' => {
          'data' => {
              'url' => 'https://someurl.com'
          }
      }
  },
  {
      'id' => 'some other long alphanumeric number',
      'name' => 'Bob Dole',
      'picture' => {
          'data' => {
              'url' => 'https://someotherurl.com'
          }
      }
  }]

  let(:koala_instance) { double(Koala::Facebook::API) }

  before do
    allow(Koala::Facebook::API).to receive(:new).and_return(koala_instance)
  end

  it 'delegates to Koala to find "taggable_friends"' do
    expect(koala_instance).to receive(:get_connections).with('me', 'taggable_friends').and_return([])

    FriendRepository.find(token: 'some token')
  end

  it 'returns a list of FriendEntity' do
    allow(koala_instance).to receive(:get_connections).and_return(TAGGABLE_FRIENDS_FIXTURE)

    friend_entities = FriendRepository.find(token: 'some token')

    expect(friend_entities).to have(2).items
    expect(friend_entities[0].class).to eq(FriendEntity)
    expect(friend_entities[1].class).to eq(FriendEntity)
  end

  it 'correctly maps name and url to the FriendEntities it returns' do
    allow(koala_instance).to receive(:get_connections).and_return(TAGGABLE_FRIENDS_FIXTURE)

    friend_entities = FriendRepository.find(token: 'some token')

    expect(friend_entities[0].name).to eq('Joe Boggs')
    expect(friend_entities[0].image_url.get).to eq('https://someurl.com')
    expect(friend_entities[0].id).to eq('some long alphanumeric number')

    expect(friend_entities[1].name).to eq('Bob Dole')
    expect(friend_entities[1].image_url.get).to eq('https://someotherurl.com')
    expect(friend_entities[1].id).to eq('some other long alphanumeric number')
  end

  context 'when picture url isnt returned' do
    TAGGABLE_FRIENDS_WITHOUT_PHOTO = [
        {
            id: 'some other long alphanumeric number',
            name: 'Bob Dole',

        }
    ]

    it 'returns image_url as an optional attribute' do
      allow(koala_instance).to receive(:get_connections).and_return(TAGGABLE_FRIENDS_WITHOUT_PHOTO)

      friend_entities = FriendRepository.find(token: 'some token')

      expect(friend_entities[0].image_url.blank?).to be(true)
      expect { friend_entities[0].image_url.get }.to raise_exception(UnwrappedNil)
    end
  end
end