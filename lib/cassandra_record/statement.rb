module CassandraRecord
  class Statement
    class << self
      def where(table_name, options={})
        cql = base_where_query(table_name)

        unless options.empty?
          cql << 'WHERE'

          clause_count = 0
          options.each do |column, value|
            cql << 'AND ' if clause_count > 0
            cql << " #{column.to_s} = #{Cassandra::Util.encode_object(value)} "
            clause_count += 1
          end
        end

        cql << ';'

        db.execute(cql)
      end

      def create(table_name, columns, values)
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

      def value_placeholders
        [].tap do |arr|
          values.count.times do
            arr << "?"
          end
        end
      end

      def base_where_query(table_name)
        cql = <<-CQL
SELECT *
FROM #{table_name}
        CQL
      end
    end
  end
end
