require 'rails_helper'

describe FetchFriendsForUser do
  let(:request) { FetchFriendsForUserRequest.new(facebook_token: 'some token'.maybe)}
  let(:listener_spy) { spy(ListenerSpy) }

  subject { FetchFriendsForUser.new(request, listener_spy)}

  describe '#perform' do
    context 'without a facebook token' do
      let(:request) { FetchFriendsForUserRequest.new(facebook_token: nil) }

      it 'calls handle_failure with error message specifying lack of token' do
        expect(listener_spy).to receive(:handle_failure).with('No facebook token for user present')

        subject.perform
      end
    end

    context 'with a facebook token' do
      it 'calls find with facebook token on FriendRepository' do
        expect(FriendRepository).to receive(:find).with(token: 'some token')

        subject.perform
      end

      it 'calls handle_success with the resulting list of FriendEntities' do
        friends = [
            FriendEntity.new(name: 'bob', image_url: 'some url'),
            FriendEntity.new(name: 'joe', image_url: 'some other url')
        ]

        allow(FriendRepository).to receive(:find).and_return(friends)

        expect(listener_spy).to receive(:handle_success).with(friends)

        subject.perform
      end
    end
  end
end