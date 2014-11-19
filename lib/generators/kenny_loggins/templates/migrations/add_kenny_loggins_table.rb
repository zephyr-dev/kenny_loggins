class AddKennyLogginsTable < ActiveRecord::Migration
  def up
    create_table_cql = <<-CQL
      CREATE TABLE IF NOT EXISTS kenny_loggins_activity_log_items (
        application_name text,
        activity_name text,
        timestamp timeuuid,
        data text,
        PRIMARY KEY (timestamp)
      );
    CQL

    create_index_cql = <<-CQL
      CREATE INDEX IF NOT EXISTS application_name_index ON kenny_loggins_activity_log_items (application_name);
    CQL

    CassandraRecord::Database::Adapters::Cassandra.instance.execute(create_table_cql)
    CassandraRecord::Database::Adapters::Cassandra.instance.execute(create_index_cql)
  end

  def down
    drop_kenny_loggins_table_cql = <<-CQL
      DROP TABLE IF EXISTS kenny_loggins_activity_log_items;
    CQL

    drop_index_cql = <<-CQL
      DROP INDEX IF EXISTS application_name_index;
    CQL

    CassandraRecord::Database::Adapters::Cassandra.instance.execute(drop_kenny_loggins_table_cql)
    CassandraRecord::Database::Adapters::Cassandra.instance.execute(drop_index_cql)
  end
end
