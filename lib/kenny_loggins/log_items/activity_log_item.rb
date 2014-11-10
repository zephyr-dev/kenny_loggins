module KennyLoggins
  class ActivityLogItem < ::CassandraRecord::Base
    class << self
      def transform(attributes)
        attributes
      end
    end
  end
end
