module KennyLoggins
  module Configuration
    class Database

      class << self
        def connection_string(environment)
          return "postgres://#{host}/#{database_name(environment)}" unless requires_authentication?
          "postgres://#{username}:#{password}@#{host}/#{database_name(environment)}"
        end

        private

        def requires_authentication?
          username.present? && password.present?
        end

        def username
          ENV['KENNY_LOGGINS_DATABASE_USERNAME']
        end

        def password
          ENV['KENNY_LOGGINS_DATABASE_PASSWORD']
        end

        def host
          ENV['KENNY_LOGGINS_DATABASE_HOST']
        end

        def database_name(environment)
          "kenny_loggins_#{environment}"
        end
      end
    end

  end
end


