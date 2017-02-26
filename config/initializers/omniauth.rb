Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.test?
    facebook_app_id = ENV['TEST_FACEBOOK_APP_ID']
    facebook_secret = ENV['TEST_FACEBOOK_SECRET']
  else
    facebook_app_id = ENV['FACEBOOK_APP_ID']
    facebook_secret = ENV['FACEBOOK_SECRET']
  end

  provider :facebook, facebook_app_id, facebook_secret,
            scope: 'email, user_friends, publish_actions',
            display: 'popup',
            info_fields: 'email, name, friends, taggable_friends'
end