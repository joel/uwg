# frozen_string_literal: true

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"

# must load BEFORE rails/test_help
require_relative "./db/sqlite_test_db_loader"

require "rails/test_help"

begin
  require "pry"
rescue LoadError
end

require "mocha/minitest"

Dir[Rails.root.join("test/support/**/*.rb")].sort.each { |f| require f }

# This assumes you're sharing config between unit/integration
module TestSetup
  extend ActiveSupport::Concern

  included do
    include FactoryBot::Syntax::Methods
    include ModelFactory
    include InputFactory

    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Make sure that you reload the sqlite when starting processes
    parallelize_setup do
      # slightly more efficient than a direct call to establish_connection
      ActiveRecord::Migration.check_pending!
    end
  end
end

class ActiveSupport::TestCase
  include TestSetup
end

class ActionDispatch::IntegrationTest
  include TestSetup
end
