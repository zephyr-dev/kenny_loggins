require 'kenny_loggins'
require 'rails'

module KennyLoggins
  class Railtie < Rails::Railtie
    railtie_name :kenny_loggins

    rake_tasks do
      load "#{KennyLoggins.root_dir}/tasks/kenny_loggins.rake"
    end
  end
end
