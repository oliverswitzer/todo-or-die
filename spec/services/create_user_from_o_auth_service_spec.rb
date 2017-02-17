require 'rails_helper'

describe CreateUserFromOAuthService do
  let(:omniauth_params) do
    {
        provider: 'provider',
        uid: 'uid',
        info: {
            email: 'foo@example.com',
            name: 'Some Person'
        },
        extra: {
            raw_info: {
                taggable_friends: {
                    data: [
                        {name: 'Foo Person', url: 'https://somephoto.com'},
                        {name: 'Other Person', url: 'https://otherphoto.com'}
                    ]
                }
            }
        }
    }
  end

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
      it 'creates the user with basic details from facebook' do
        expect(User.count).to eq(0)

        user = CreateUserFromOAuthService.perform(omniauth_params)

        expect(User.count).to eq(1)
        expect(user.uid).to eq('uid')
        expect(user.provider).to eq('provider')
        expect(user.email).to eq('foo@example.com')
        expect(user.name).to eq('Some Person')
      end

      describe 'users friends' do
        it 'creates a Friend for each taggable_friend present' do
          expect(Friend.count).to eq(0)

          user = CreateUserFromOAuthService.perform(omniauth_params)

          expect(Friend.count).to eq(2)
          expect(user.friends[0].name).to eq('Foo Person')
          expect(user.friends[1].name).to eq('Other Person')
        end
      end
    end
  end
end