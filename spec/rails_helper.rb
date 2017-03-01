# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'rspec/mocks'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'devise/controllers/helpers'
require 'capybara-screenshot/rspec'

ActiveRecord::Migration.check_pending!

Capybara.default_driver = :poltergeist

Capybara::Screenshot.register_filename_prefix_formatter(:rspec) do |example|
  "screenshot_#{example.description.gsub(' ', '-').gsub(/^.*\/spec\//,'')}"
end
Capybara::Screenshot.append_timestamp = false
Capybara.server_port = 3001
Capybara.app_host = 'http://localhost:3001'

RSpec.configure do |config|
  config.include RSpec::Mocks
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Capybara::DSL
  config.infer_spec_type_from_file_location!

  config.before(:suite) do
    DatabaseCleaner.orm = 'active_record'
    DatabaseCleaner.clean_with :truncation
    DatabaseCleaner.strategy = :truncation

    FileUtils.rm(Dir.glob("#{Rails.root}/tmp/capybara/*"))
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    FactoryGirl.find_definitions
  end

  # config.after(:each) { Warden.test_reset! }

end
