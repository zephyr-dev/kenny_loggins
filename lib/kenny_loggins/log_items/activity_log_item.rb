module KennyLoggins
  class ActivityLogItem < ::CassandraRecord::Base
    class << self
      def transform(attributes)
        attributes
      end
    end

    def to_hash
      @attributes
    end
  end
end
