DROP KEYSPACE IF EXISTS kenny_loggins;

CREATE KEYSPACE kenny_loggins
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': '1'};

USE kenny_loggins;

CREATE TABLE kenny_loggins_activity_log_items (
  application_name text,
  activity_name text,
  timestamp timeuuid,
  data text,
  PRIMARY KEY (timestamp)
);

CREATE INDEX application_name_index ON kenny_loggins_activity_log_items (application_name);

