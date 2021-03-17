# frozen_string_literal: true

Rake::Task["db:test:load_schema"].clear

namespace :db do
  namespace :test do
    task :load_schema do
      puts("OVERRIDDEN rake task db:test:load_schema")
    end
  end
end