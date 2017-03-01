require 'rails_helper'

describe UserRepository do
  let(:user_entity) do
    UserEntity.new(
        provider: 'provider',
        uid: 'uid',
        email: 'foo@example.com',
        name: 'Some Person',
        password: 'some password'
    )
  end

  describe 'find_or_create' do
    context 'when user exists' do
      let!(:user) { FactoryGirl.create(:user,
           uid: 'uid',
           provider: 'provider'
      )}

      it 'does not increment the number of persisted users' do
        expect(User.count).to eq(1)

        UserRepository.find_or_create(user_entity: user_entity)

        expect(User.count).to eq(1)
      end

      it 'sets the id of the user on the UserEntity' do
        UserRepository.find_or_create(user_entity: user_entity)

        expect(user_entity.id).to eq(User.last.id)
      end

      it 'returns true' do
        expect(UserRepository.find_or_create(user_entity: user_entity)).to be(true)
      end
    end

    context 'when user does not exist' do
      it 'increments the number of persisted users by 1' do
        expect(User.count).to eq(0)

        UserRepository.find_or_create(user_entity: user_entity)

        expect(User.count).to eq(1)
      end

      it 'creates the user with correct attributes' do
        UserRepository.find_or_create(user_entity: user_entity)

        persisted_user = User.last

        expect(persisted_user.uid).to eq('uid')
        expect(persisted_user.provider).to eq('provider')
        expect(persisted_user.email).to eq('foo@example.com')
        expect(persisted_user.name).to eq('Some Person')
        expect(persisted_user.id).to eq(persisted_user.id)
      end

      it 'sets the id of the user on the UserEntity' do
        UserRepository.find_or_create(user_entity: user_entity)

        expect(user_entity.id).to eq(User.last.id)
      end

      it 'returns true' do
        expect(UserRepository.find_or_create(user_entity: user_entity)).to be(true)
      end
    end

    context 'when persisting fails due to validation' do
      let(:user_entity) do
        UserEntity.new(
            password: '2SHORT'
        )
      end

      it 'returns false' do
        expect(UserRepository.find_or_create(user_entity: user_entity)).to be(false)
      end
    end
  end
end