require 'erb'
require 'kenny_loggins'

task :environment do
end

namespace :kenny_loggins do 
  namespace :structure do
    desc "Loads your structures"
    task :load => :environment do
      structure_file = ERB.new(File.read("#{KennyLoggins.root_dir}/db/cassandra_structure.cql")).result
      File.open('tmpfile', 'w') do |f|
        f.write(structure_file)
      end

      `cqlsh -f tmpfile`
      File.delete('tmpfile')
    end
  end
end
