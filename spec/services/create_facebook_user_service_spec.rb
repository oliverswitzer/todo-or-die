require 'spec_helper'
require_relative '../../app/services/create_facebook_user_service'


describe CreateFacebookUserService do
  describe 'perform' do
    let(:omniauth_params) {
      {
          provider: 'provider',
          uid: 'uid'
      }
    }

    class UserFake
      def self.where ; end
      def self.first_or_create ; end
    end

    class ListenerFake
    end

    let(:user_klass) { double(UserFake) }
    let(:listener) { spy(ListenerFake) }
    let(:service) { CreateFacebookUserService.new(omniauth_params, listener, user_klass) }
    let(:where_return_object) { spy(Object) }

    before do
      allow(where_return_object).to receive(:first_or_create)  { user }
      allow(user_klass).to receive(:where) { where_return_object }

    end

    it 'queries the User class for provider and uid passed in omniauth params' do
      service.perform
      expect(user_klass).to have_received(:where).with(provider: 'provider', uid: 'uid')
    end

    it 'calls find_or_create on the where query' do
      service.perform
      expect(where_return_object).to have_received(:first_or_create)
    end

    let(:user) { spy(Object) }

    it 'checks if the user is persisted' do
      service.perform
      expect(user).to have_receive(:persisted?)
    end

    context 'user is persisted' do
      before do
        allow(user).to receive(:persisted?) { true }
      end

      it 'calls sign_in_and_redirect on the listener with @user' do
        service.perform
        expect(listener).to have_received(:sign_in_and_redirect).with(user)
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
        allow(user).to receive(:persisted?) { false }
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