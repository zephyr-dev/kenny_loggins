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

      def batch_log(items)
        items.group_by { |item| item[:activity_name] }.each do |activity_name, items|
          log_item_types_for(activity_name).each do |log_item_type|
            transformed_items = []
            items.each do |item|
              transformed_items.push(log_item_type.transform(item))
            end
            log_item_type.batch_create(transformed_items)
          end
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
        [KennyLoggins.default_log_item_type]
      end
    end
  end
end
