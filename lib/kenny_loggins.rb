require 'rubygems'
require 'pry'

require 'cassandra_record/base'
require 'cassandra_record/statement'
require 'cassandra_record/database/adapters/cassandra'

require 'kenny_loggins/log_items/activity_log_item'
require 'kenny_loggins/logger'
require 'kenny_loggins/version'

module KennyLoggins
  CassandraRecord::Database::Adapters::Cassandra.instance.use("kenny_loggins")
end
