require 'kenny_loggins'

CassandraRecord::Database::Adapters::Cassandra.instance.use("cassandra_test")

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'

  # create test keyspace and table
  db = CassandraRecord::Database::Adapters::Cassandra.instance
  keyspace = 'cassandra_test'

  config.add_setting :db
  config.add_setting :keyspace
  config.db = db
  config.keyspace = keyspace

  drop_keyspace = <<-CQL
    DROP KEYSPACE IF EXISTS #{keyspace};
  CQL

  create_keyspace = <<-CQL
    CREATE KEYSPACE #{keyspace}
    WITH replication = {'class': 'SimpleStrategy', 'replication_factor': '1'};
    CQL

  drop_test_table = <<-CQL
    DROP TABLE IF EXISTS testrecords;
  CQL

  create_test_table = <<-CQL
    CREATE TABLE testrecords (
      id int,
      name text,
      PRIMARY KEY (id)
    );
  CQL

  create_table_index = <<-CQL
    CREATE INDEX name_index ON testrecords (name);
  CQL

  truncate_table = <<-CQL
    TRUNCATE testrecords;
  CQL

  db.cluster.execute(drop_keyspace)
  db.cluster.execute(create_keyspace)
  db.use(keyspace)
  db.execute(drop_test_table)
  db.execute(create_test_table)
  db.execute(create_table_index)

  config.after(:all) do
    db.execute(truncate_table)
  end
end
