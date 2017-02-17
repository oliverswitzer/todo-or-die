require 'rails_helper'

RSpec.describe FriendsController, type: :controller do
  before do
    allow(subject).to receive(:current_user).and_return(FactoryGirl.build(:user))
  end

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
