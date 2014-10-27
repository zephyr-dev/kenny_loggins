require 'active_record'
require 'bundler'

require 'kenny_loggins/configuration/application'
require 'kenny_loggins/configuration/database'
require 'kenny_loggins/application_model'
require 'kenny_loggins/version'
require 'kenny_loggins/application'
require 'kenny_loggins/event'

module KennyLoggins
  ::Bundler.require(:default, Configuration::Application.environment.to_sym)
end
