require 'cassandra'

module Database
  module Adapters
    class Cassandra

      class << self
        def prepare(cql)
          session.prepare(cql)
        end

        def execute(cql, *args)
          binding.pry
          session.execute(cql, *args)
        end

        def cluster
          ::Cassandra.cluster.connect
        end

        def session
          @session ||= ::Cassandra.cluster.connect('kenny_loggins')
        end
      end

    end
  end
end

