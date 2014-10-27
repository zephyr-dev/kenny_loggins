require "bundler/gem_tasks"
require 'active_record'
require 'kenny_loggins'

MIGRATIONS_DIR='db/migrate'

task :environment do
  ActiveRecord::Base.establish_connection KennyLoggins::Configuration::Application.database_connection_string
end

namespace :db do
  desc "Migrates"
  task migrate: :environment do
    ActiveRecord::Migrator.migrate MIGRATIONS_DIR
  end

  desc "Unmigrates"
  task rollback: :environment do
    ActiveRecord::Migrator.rollback MIGRATIONS_DIR
  end

  desc "Migrates test database"
  namespace :test do
    task :environment do
      KennyLoggins::Configuration::Application.environment = 'test'
      ActiveRecord::Base.establish_connection KennyLoggins::Configuration::Application.database_connection_string
    end

    task prepare: :environment do
      ActiveRecord::Migrator.migrate MIGRATIONS_DIR
    end
  end
end
