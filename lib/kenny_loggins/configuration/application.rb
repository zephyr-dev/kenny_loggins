module KennyLoggins
  module Configuration
    class Application

      class << self
        def environment
          @environment ||= ENV['APPLICATION_ENVIRONMENT'] || "production"
        end

        def environment=(environment)
          @environment = environment
        end

        def database_connection_string
          db.connection_string(environment)
        end

        private

        def db
          @db ||= ::KennyLoggins::Configuration::Database
        end
      end

    end
  end
end

