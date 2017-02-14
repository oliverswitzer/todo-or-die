require "rails_helper"
require "helpers/authentication_helper"

describe OmniauthCallbacksController, type: :controller do
  include AuthenticationHelper

  describe "POST facebook" do
    let(:create_facebook_user_servie) { spy(CreateFacebookUserService) }

    before do
      mock_omniauth_for_facebook
      @user_mock_info = OmniAuth.config.mock_auth[:facebook]

      @request.env["omniauth.auth"] = @user_mock_info
      @request.env["devise.mapping"] = Devise.mappings[:user]
    end

    it "instantiates the CreateFacebookUserService" do
      expect(CreateFacebookUserService).to receive(:new).with(@user_mock_info, subject).and_call_original
      post :facebook
    end

    it "calls perform on the CreateFacebookUserService instance" do
      expect_any_instance_of(CreateFacebookUserService).to receive(:perform).and_call_original
      post :facebook
    end
  end
end