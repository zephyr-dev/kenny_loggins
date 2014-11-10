require "bundler/gem_tasks"
require 'kenny_loggins'

task :environment do
end

namespace :kenny_loggins do 
  namespace :structure do
    desc "Loads your structures"
    task :load => :environment do
      filepath = File.dirname(__FILE__) + "/db/cassandra_structure.cql"
      `cqlsh -f #{filepath}`
    end
  end
end
