require 'rails_helper'

RSpec.describe FriendsController, type: :controller do
  describe '.handle_success' do
    it 'renders the friends to the view' do
      friends = [FriendEntity.new(name: 'Bob', image_url: 'foo', id: 1)]

      subject.handle_success(friends)

      expect(assigns(:friends)).to equal(friends)
    end
  end

  describe '.handle_failure' do
    it 'creates a flash message with error passed in as argument' do
      subject.handle_failure('some error message')

      expect(flash[:error]).to eq('some error message')
    end
  end
end
