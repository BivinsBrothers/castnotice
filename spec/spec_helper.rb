ENV["RAILS_ENV"] ||= "test"

if ENV["CODECLIMATE_REPO_TOKEN"]
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

require File.expand_path("../../config/environment", __FILE__)
require "rspec/rails"
require "rspec/autorun"

require "capybara/rspec"
require "capybara/poltergeist"
require "capybara/email/rspec"

require "billy/rspec"

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, inspector: true, timeout: 60)
end

Billy.configure do |c|
  c.cache = true
  c.persist_cache = true
  c.ignore_cache_port = true
  c.whitelist = [ '127.0.0.1', 'localhost', 'netdna.bootstrapcdn.com', 'js.stripe.com', 'fonts.googleapis.com', 'bucket.s3.amazonaws.com', 'placekitten.com', 's.ytimg.com', 'www.google.com', 'www.youtube.com' ]
  c.ignore_params = [ "https://js.stripe.com/v2", "https://api.stripe.com/v1/tokens" ]
  c.non_whitelisted_requests_disabled = false # disable new HTTP connections when true
  c.non_successful_error_level = :error
  c.cache_path = "spec/billy_cache"
end
Capybara.javascript_driver = :poltergeist_billy

VCR.configure do |c|
  c.cassette_library_dir = "spec/cassettes"
  c.hook_into :webmock
  c.allow_http_connections_when_no_cassette = true
end

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.include(FactoryGirl::Syntax::Methods)
  config.include(Authentication::Helpers)
  config.include Devise::TestHelpers, :type => :controller
  config.include Warden::Test::Helpers

  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
end
