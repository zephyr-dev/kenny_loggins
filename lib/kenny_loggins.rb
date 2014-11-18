require 'rubygems'
require 'pry'

require 'cassandra_record'

require 'kenny_loggins/log_items/activity_log_item'
require 'kenny_loggins/logger'
require 'kenny_loggins/version'

module KennyLoggins
  require 'kenny_loggins/railtie' if defined?(Rails)

  def self.root_dir
    File.expand_path '..', __dir__
  end
end
