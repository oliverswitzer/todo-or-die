require 'rails_helper'

describe UserConverter do
  describe '#convert_to_active_record' do
    it 'coverts from a UserEntity to User active record object' do

      user_entity = UserEntity.new(
        provider: 'some provider',
        uid: 'some uid',
        id: 'some id',
        password: 'some password',
        email: 'some email',
        name: 'some name'
      )

      active_record_user = UserConverter.convert_to_active_record(user_entity: user_entity)

      expect(active_record_user.class).to eq(User)
      expect(active_record_user.provider).to eq('some provider')
      expect(active_record_user.uid).to eq('some uid')
      expect(active_record_user.password).to eq('some password')
      expect(active_record_user.email).to eq('some email')
      expect(active_record_user.name).to eq('some name')
    end
  end

  it 'coverts from a User active record object to a UserEntity' do
    user = User.new(
        provider: 'some provider',
        uid: 'some uid',
        id: 'some id',
        password: 'some password',
        email: 'some email',
        name: 'some name'
    )

    user_entity = UserConverter.convert_to_entity(active_record_user: user)

    expect(user_entity.class).to eq(UserEntity)
    expect(user_entity.provider).to eq('some provider')
    expect(user_entity.uid).to eq('some uid')
    expect(user_entity.password).to eq('some password')
    expect(user_entity.email).to eq('some email')
    expect(user_entity.name).to eq('some name')
  end
end