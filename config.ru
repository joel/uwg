# frozen_string_literal: true

# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

begin
  require 'pry'
rescue LoadError
end

run Rails.application
Rails.application.load_server
