require 'rails_helper'
require_relative '../../app/services/create_facebook_user_service'
require_relative '../../app/models/user'

describe CreateFacebookUserService do
  describe 'perform' do
    let(:omniauth_params) {
      {
          provider: 'provider',
          uid: 'uid'
      }
    }


    class ListenerFake
    end

    let(:listener) { spy(ListenerFake) }
    let(:service) { CreateFacebookUserService.new(omniauth_params, listener) }
    let(:fake_user) { double(User) }

    before do
      allow(CreateUserFromOAuthService).to receive(:perform).and_return(fake_user)
    end

    context 'user is persisted' do
      before do
        allow(fake_user).to receive(:persisted?) { true }
      end

      it 'calls sign_in_and_redirect on the listener with @user' do
        service.perform
        expect(listener).to have_received(:sign_in_and_redirect).with(fake_user)
      end

      it 'sets a flash message on the controller' do
        service.perform
        expect(listener).to have_received(:set_flash_message).with(
                                :notice,
                                :success,
                                kind: 'Facebook'
                            )
      end
    end

    context 'user is not persisted' do
      before do
        allow(fake_user).to receive(:persisted?) { false }
      end
      
      it 'calls error_creating_facebok_user on listener with error message' do
        service.perform
        expect(listener).to have_received(:failure)
      end

      it 'sets a flash message on the controller' do
        service.perform
        expect(listener).to have_received(:set_flash_message).with(
                                :notice,
                                :failure,
                                kind: 'Facebook'
                            )
      end
    end
  end
end