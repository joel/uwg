require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Upgrowweblog
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.active_record.schema_format = :sql

    if ENV["RAILS_LOG_TO_STDOUT"].present?
      STDOUT.sync = true
      config.rails_semantic_logger.add_file_appender = false
      config.semantic_logger.add_appender(io: STDOUT, level: config.log_level, formatter: config.rails_semantic_logger.format)
    end

    if ENV["LOG_LEVEL"].present?
      config.log_level = ENV["LOG_LEVEL"].downcase.strip.to_sym
    end

    if ENV["LOG_APPENDER"].present?
      config.rails_semantic_logger.started    = true
      config.rails_semantic_logger.processing = true
      config.rails_semantic_logger.rendered   = true
    end
  end
end
