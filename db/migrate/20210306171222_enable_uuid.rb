class EnableUuid < ActiveRecord::Migration[6.1]
  def change
    case ActiveRecord::Base.connection.class
    when ActiveRecord::ConnectionAdapters::PostgreSQLAdapter
      enable_extension 'pgcrypto'
    else
      Rails.logger.warn("No Encryption found for [#{ActiveRecord::Base.connection.class}]")
    end
  end
end
