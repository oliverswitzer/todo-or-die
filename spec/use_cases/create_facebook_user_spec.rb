require 'rails_helper'
require_relative '../../app/use_cases/create_facebook_user'
require_relative '../../app/models/user'

describe CreateFacebookUser do
  describe 'perform' do
    class ListenerSpy; end
    let(:listener_spy) { spy(ListenerSpy) }

    let(:create_user_request) {
      CreateFacebookUserRequest.new(
          provider: 'some provider'.maybe,
          email: 'email'.maybe,
          name: 'name'.maybe,
          uid: 'uid'.maybe,
          random_token: 'some random token'.maybe
      )
    }

    let(:subject) { CreateFacebookUser.new(create_user_request, listener_spy) }

    context 'user is persisted' do
      before do
        allow(UserRepository).to receive(:find_or_create).and_return(true)
      end

      it 'calls handle_success with user entity' do
        subject.perform
        expect(listener_spy).to have_received(:handle_success).with(instance_of(UserEntity))
      end
    end

    context 'user is not persisted' do
      before do
        allow(UserRepository).to receive(:find_or_create).and_return(false)
      end
      
      it 'calls handle_failure on listener with error message' do
        subject.perform
        expect(listener_spy).to have_received(:handle_failure)
      end
    end
  end
end