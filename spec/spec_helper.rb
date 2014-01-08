require 'rubygems'
require 'spork'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  # Checks for pending migrations before tests are run.
  # If you are not using ActiveRecord, you can remove this line.
  ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)
  RSpec.configure do |config|
    # == Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, # uncomment the appropriate line:
    #
    # config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr
    # Remove this line if you're not using ActiveRecord # or ActiveRecord fixtures
    config.fixture_path = "#{::Rails.root}/spec/fixtures"
    # If you're not using ActiveRecord, or you'd prefer not to run each of
    # your examples within a transaction, remove the following line or
    # assign false instead of true.
    config.use_transactional_fixtures = false # use database-cleaner
    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false
    # Run specs in random order to surface order dependencies. If you
    # find an order dependency and want to debug it, you can fix the
    # order by providing the seed, which is printed after each run.
    # --seed 1234
    config.order = "random"
    config.include Capybara::DSL
    # Disable the old-style object.should syntax.
    config.expect_with :rspec do |c|
      c.syntax = :expect
    end
    require 'capybara-webkit'
    Capybara.javascript_driver = :webkit
    # for database_cleaner
    config.before :each do
      if Capybara.current_driver == :rack_test
        DatabaseCleaner.strategy = :transaction
        DatabaseCleaner.start
      else
        DatabaseCleaner.strategy = :truncation
      end
    end
    config.after(:each) do
      DatabaseCleaner.clean
    end
  end
  # headless settings
  require "headless"
  headless = Headless.new(:display => 99)
  headless.start
  at_exit{ headless.destroy }
end

Spork.each_run do
  # This code will be run each time you run your specs.
  FactoryGirl.reload
end
