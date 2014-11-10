module CassandraRecord
  class Statement
    class << self
      def where(table_name, options={})
        cql = base_where_query(table_name)

        if options.present?
          cql << 'WHERE'
          cql << parse_where_clause_options(options)
        end

        cql << ';'
        db.execute(cql)
      end

      def create(table_name, columns, values)
        cql = <<-CQL
INSERT INTO #{table_name} (#{columns.join(", ")})
VALUES (#{value_placeholders(values).join(", ")})
        CQL

        insert_statement = db.prepare(cql)
        db.execute(insert_statement, *values)
      end

      private

      def db
        Database::Adapters::Cassandra.instance
      end

      def value_placeholders(values)
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

      def parse_where_clause_options(options)
        return options if options.is_a?(String)

        clause_count = 0
        "".tap do |cql|
          options.each do |column, value|
            cql << ' AND' if clause_count > 0
            cql << " #{column.to_s} = #{Cassandra::Util.encode_object(value)}"
            clause_count += 1
          end
        end
      end
    end
  end
end
