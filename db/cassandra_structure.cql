USE <%= CassandraRecord::Database::Adapters::Cassandra.instance.keyspace %>;

CREATE TABLE IF NOT EXISTS kenny_loggins_activity_log_items (
  application_name text,
  activity_name text,
  timestamp timeuuid,
  data text,
  PRIMARY KEY (timestamp)
);

CREATE INDEX IF NOT EXISTS application_name_index ON kenny_loggins_activity_log_items (application_name);

