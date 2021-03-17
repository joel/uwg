# frozen_string_literal: true

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

Rails.application.load_tasks

Rake::Task["default"].clear

require "standard/rake"

task :default do
  # Rake::Task["db:test:load_memory_schema"].invoke
  # Rake::Task["test:all"].invoke
  # Rake::Task["db:test:clean_memory_schema"].invoke

  Rake::Task["brakeman:check"].invoke
  Rake::Task["standard:fix"].invoke
  Rake::Task["rails_best_practices:run"].invoke

  Rake::Task["reek:run"].invoke
end
