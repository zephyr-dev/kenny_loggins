require 'kenny_loggins'

RSpec.configure do |config|
  Bundler.require(:default, :test)

  KennyLoggins::Configuration::Application.environment = 'test'
  KennyLoggins::ApplicationModel.establish_connection KennyLoggins::Configuration::Application.database_connection_string
end
