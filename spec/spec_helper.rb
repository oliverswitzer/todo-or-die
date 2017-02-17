# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
require 'factory_girl'
require 'database_cleaner'
require 'rspec/mocks'
RSpec.configure do |config|
  config.include RSpec::Mocks

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end

