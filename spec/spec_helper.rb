# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
require 'factory_girl'
require 'database_cleaner'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.before(:suite) do
    DatabaseCleaner.orm = "active_record"
    DatabaseCleaner.clean_with :truncation
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
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end

