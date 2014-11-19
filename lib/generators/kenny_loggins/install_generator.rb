module KennyLoggins
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      desc "Generates the cassandra migration to add the kenny_loggins_activity_log_item table"

      def create_migration
        Dir["#{self.class.source_root}/migrations/*.rb"].sort.each do |filepath|
          name = File.basename(filepath)
          timestamped_name = "#{DateTime.now.strftime("%Y%m%d%H%M%S")}_#{name}"
          template "migrations/#{name}", "db/migrate/#{timestamped_name}"
        end
      end
    end
  end
end
