require 'rails_helper'
require_relative '../../app/use_cases/create_facebook_user'
require_relative '../../app/models/user'

describe CreateFacebookUser do
  describe 'perform' do
    let(:omniauth_params) {
      {
          provider: 'provider',
          uid: 'uid'
      }
    }


    class ListenerFake
    end

    let(:listener_spy) { spy(ListenerFake) }
    let(:service) { CreateFacebookUser.new(omniauth_params, listener_spy) }
    let(:user_stub) { double(User) }

    before do
      allow(CreateUserFromOAuthService).to receive(:perform).and_return(user_stub)
    end

    context 'user is persisted' do
      before do
        allow(user_stub).to receive(:persisted?) { true }
      end

      it 'calls sign_in_and_redirect on the listener with @user' do
        service.perform
        expect(listener_spy).to have_received(:sign_in_and_redirect).with(user_stub)
      end

      it 'sets a flash message on the controller' do
        service.perform
        expect(listener_spy).to have_received(:set_flash_message).with(
                                :notice,
                                :success,
                                kind: 'Facebook'
                            )
      end
    end

    context 'user is not persisted' do
      before do
        allow(user_stub).to receive(:persisted?) { false }
      end
      
      it 'calls error_creating_facebok_user on listener with error message' do
        service.perform
        expect(listener_spy).to have_received(:failure)
      end

      it 'sets a flash message on the controller' do
        service.perform
        expect(listener_spy).to have_received(:set_flash_message).with(
                                :notice,
                                :failure,
                                kind: 'Facebook'
                            )
      end
    end
  end
end