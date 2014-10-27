module KennyLoggins
  class ApplicationModel < ActiveRecord::Base
    self.abstract_class = true
    self.establish_connection ::KennyLoggins::Configuration::Application.database_connection_string
  end
end

