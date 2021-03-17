# frozen_string_literal: true

Rake::Task["db:test:load_schema"].clear

namespace :db do
  namespace :test do
    task :load_schema do
      puts("OVERRIDDEN rake task db:test:load_schema")
    end
  end
end

require_relative "../../test/db/sqlite_test_db_loader"
require "tempfile"

namespace :db do
  namespace :test do
    task :load_memory_schema do
      puts("Load memory schema.rb")

      instance = SqliteTestDbLoader.new
      schema = instance.extract

      @file = Tempfile.new
      @file.write(instance.transform(schema))
      @file.rewind

      ENV["SCHEMA"] = @file.path
    end

    task :clean_memory_schema do
      puts("Clean memory schema.rb")

      @file.close
      @file.unlink # deletes the temp file
    end
  end
end
