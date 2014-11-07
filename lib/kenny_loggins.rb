require 'rubygems'
require 'pry'
require 'cassandra/record'
require 'kenny_loggins/database/adapters/cassandra'
require 'kenny_loggins/version'

module KennyLoggins
  class Logger

  end

  class LogItem < ::Cassandra::Record; end
end
