# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'devise'
require 'capybara-screenshot/rspec'

ActiveRecord::Migration.check_pending!

# Capybara.default_driver = :selenium
Capybara.javascript_driver = :poltergeist

Capybara::Screenshot.register_filename_prefix_formatter(:rspec) do |example|
  "screenshot_#{example.description.gsub(' ', '-').gsub(/^.*\/spec\//,'')}"
end
Capybara::Screenshot.append_timestamp = false

RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
  config.include Capybara::DSL
  config.infer_spec_type_from_file_location!

  config.before(:suite) do
    DatabaseCleaner.orm = 'active_record'
    DatabaseCleaner.clean_with :truncation
    FileUtils.rm(Dir.glob("#{Rails.root}/tmp/capybara/*"))
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each, :database) do
    DatabaseCleaner.start
  end

  config.after(:each, :database) do
    DatabaseCleaner.clean
  end

  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    FactoryGirl.find_definitions
  end

end
