module KennyLoggins
  class NoopLogItem
    class << self
      def create(attributes)
        # noop
      end

      def where(attributes)
        []
      end

      def transform(attributes)
        # noop
      end
    end

    def to_hash
      # noop
    end
  end
end

