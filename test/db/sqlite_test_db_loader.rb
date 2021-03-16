#### evals the schema into the current process
class SqliteTestDbLoader
  REPLACEMENTS = {
    /enable_extension/ => '# enable_extension',
    /id: :uuid/ => 'id: :string',
    /default: -> { "gen_random_uuid\(\)" },/ => ''
  }.freeze

  class << self
    def reload!(context)
      new.reload!
    ensure
      puts "Reloaded Schema: #{context}"
    end
  end

  # grab schema from fs
  def extract
    File.read(
      Rails.root.join(
        'db', 'schema.rb'
      )
    )
  end

  # Get rid of non-standard SQL unimportables
  def transform(schema)
    output = REPLACEMENTS.reduce(schema) do |res, replacement|
      res.gsub(*replacement)
    end
    # output.split("\n").each do |line|
    #   puts line
    # end
    output
  end

  # load into sqlite's :memory: db
  def load(schema)
    eval(schema)
  end

  def reload!() = load(transform(extract))
end

# Always load schema into :memory: after a new connection
module SqlitePostConnectionLoad
  def establish_connection(*args, &block)
    super
    connection
      .migration_context
      .needs_migration? &&
      SqliteTestDbLoader.reload!("#{self.class.name}#establish_connection")
  end
end

# "rails/test_help" needs a connection early on in the test_helper load process
module CheckPendingSoftly
  def check_pending!(conn = ActiveRecord::Base.connection)
    conn
      .migration_context
      .needs_migration?
      .yield_self do |needs_migration|
      needs_migration &&
        SqliteTestDbLoader.reload!("#{self.class.name}#check_pending!")
    end
  end
end

module PreserveParallelMemoryDatabase
  def create_and_load_schema(i, env_name:)
    if ActiveRecord::Base
       .configurations
       .configs_for(env_name: env_name)
       .to_s.match(/:memory:/m)
      puts 'Memory database found. Skipping db creation'
      ActiveRecord::Base.establish_connection(Rails.env.to_sym)
      return
    end
    super
  end
end

ActiveSupport.on_load(:active_record) do
  ActiveRecord::Migration.singleton_class.prepend CheckPendingSoftly
  ActiveRecord::TestDatabases.singleton_class.prepend PreserveParallelMemoryDatabase
end