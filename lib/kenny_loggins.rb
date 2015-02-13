require 'rubygems'
require 'cassandra_record'

require 'kenny_loggins/log_items/activity_log_item'
require 'kenny_loggins/logger'
require 'kenny_loggins/version'

module KennyLoggins
  require 'kenny_loggins/railtie' if defined?(Rails)

  module_function

  def root_dir
    File.expand_path '..', __dir__
  end

  def default_log_item_type
    Configuration.instance.default_log_item_type
  end

  def configure
    yield Configuration.instance
  end

  class Configuration
    include Singleton

    def default_log_item_type
      @default_log_item_type || ActivityLogItem
    end

    def default_log_item_type=(type)
      @default_log_item_type = type
    end
  end
end
