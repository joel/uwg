# frozen_string_literal: true

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

begin
  require "pry"
rescue LoadError
end

require "mocha/minitest"

Dir[Rails.root.join("test/support/**/*.rb")].sort.each { |f| require f }
class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods
  include ModelFactory
  include InputFactory

  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
