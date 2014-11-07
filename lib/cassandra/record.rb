require 'active_support/inflector'
require 'dbi'

module Cassandra
  class Record
    class << self
      def create(attributes)
        new(attributes).create
      end
    end

    attr_accessor :attributes

    def initialize(attributes)
      @attributes = attributes
    end

    def create
      cql = <<-CQL
INSERT INTO #{table_name} (#{columns.join(", ")})
VALUES (#{value_placeholders.join(", ")})
      CQL

      db.execute(cql, *values)
    end

    private

    def db
      Database::Adapters::Cassandra
    end

    def table_name
      ActiveSupport::Inflector.tableize(
        ActiveSupport::Inflector.parameterize(self.class.name))
    end

    def columns
      attributes.keys
    end

    def values
      attributes.values.map { |value| Cassandra::Util.encode_object(value) }
    end

    def value_placeholders
      [].tap do |arr|
        values.count.times do
          arr << "?"
        end
      end
    end

  end
end
