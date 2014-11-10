module KennyLoggins
  class Logger
    class << self
      def log(attributes={})
        event_name = attributes[:activity_name]
        log_item_types_for(event_name).each do |log_item|
          log_item_attributes = log_item.transform(attributes)
          log_item.create(log_item_attributes)
        end
      end

      def register_log_item_type(log_item_type)
        registered_log_item_types << log_item_type
      end

      private

      def log_item_types_for(event_name)
        matching_log_item_types = registered_log_item_types.select { |log_item| log_item::SUBSCRIBED_EVENT == event_name }
        default_log_item_types + matching_log_item_types
      end

      def registered_log_item_types
        @registered_log_item_types ||= Set.new
      end

      def default_log_item_types
        [ActivityLogItem]
      end
    end
  end
end
