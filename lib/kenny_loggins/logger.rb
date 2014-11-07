module KennyLoggins
  class Logger
    class << self
      def register_log_item_type(log_item_type)
        @registered_log_item_types << log_item_type
      end

      def log(event_name, attributes={})
        log_item_types_for(event_name).each do |log_item|
          log_item.create(attributes)
        end
      end

      def log_item_types_for(event_name)
        matching_log_item_types = registered_log_item_types.select { |log_item| log_item::SUBSCRIBED_EVENT == event_name }
        default_log_item_types + matching_log_item_types
      end

      def registered_log_item_types
        @registered_log_item_types
      end

      def default_log_item_types
        [LogItem]
      end
    end
  end
end
