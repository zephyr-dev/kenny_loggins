require 'active_support/inflector'

module CassandraRecord
  class Base
    class << self
      def create(attributes)
        new(attributes).create
      end

      def where(attributes={})
        new.where(attributes)
      end
    end

    attr_accessor :attributes

    def initialize(attributes={})
      @attributes = attributes
    end

    def where(options={})
      Statement.where(table_name, options)
    end

    def create
      Statement.create(table_name, columns, values)
    end

    private

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

  end
end
