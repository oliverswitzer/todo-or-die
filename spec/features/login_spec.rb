require 'rails_helper'
require 'helpers/omniauth_helper'

describe 'visiting the homepage', type: :feature do
  include OmniAuthHelper

  before do
    mock_omniauth_for_facebook
    # Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
    # Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
  end

  it 'user can create account with facebook' do
    visit '/'
    click_link_or_button "Sign up with Facebook"
    expect(page).to have_content("Success")
    expect(page).to have_content("Joe Bloggs")
    screenshot_and_save_page
  end
end
