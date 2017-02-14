require 'rails_helper'

describe CreateUserFromOAuthService do
  let(:omniauth_params) {
    {
        provider: 'provider',
        uid: 'uid',
        info: {
            email: 'foo@example.com',
            name: 'Some Person'
        }
    }
  }

  describe 'perform' do
    context 'when user exists' do
      let!(:user) { FactoryGirl.create(:user, uid: 'uid', provider: 'provider',
                                            name: 'Already Created', email: 'hello@example.com') }

      it 'returns the user' do
        expect(User.count).to eq(1)

        user = CreateUserFromOAuthService.perform(omniauth_params)

        expect(User.count).to eq(1)

        expect(user.uid).to eq('uid')
        expect(user.provider).to eq('provider')
        expect(user.email).to eq('hello@example.com')
        expect(user.name).to eq('Already Created')
      end
    end

    context 'when user does not exist' do
      it 'creates the user' do
        expect(User.count).to eq(0)

        user = CreateUserFromOAuthService.perform(omniauth_params)

        expect(User.count).to eq(1)
        expect(user.uid).to eq('uid')
        expect(user.provider).to eq('provider')
        expect(user.email).to eq('foo@example.com')
        expect(user.name).to eq('Some Person')
      end
    end
  end
end