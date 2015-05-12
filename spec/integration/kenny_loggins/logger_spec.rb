require 'spec_helper'
require 'active_support/hash_with_indifferent_access'

describe KennyLoggins::Logger do
  class TestLogItemBase < ::CassandraRecord::Base;
    class << self
      def transform(raw_attrs)
        parse_raw_attrs(raw_attrs)
      end

      private

      def parse_raw_attrs(attrs)
        return {} unless attrs.has_key?(:data)
        data = JSON.parse(attrs[:data])
        HashWithIndifferentAccess.new({
          blah: data['how_many'],
          whatever: data['things']
        })
      end
    end
  end

  class MatchingLogItem < TestLogItemBase
    SUBSCRIBED_EVENT = 'cool event'
  end

  class NonMatchingLogItem < ::CassandraRecord::Base;
    SUBSCRIBED_EVENT = 'terrible event'
  end

  describe ".batch_log" do
    let(:event_data) do
      [
        {
          application_name: 'test_app',
          activity_name: 'cool event',
          timestamp: Cassandra::Uuid::Generator.new.at(DateTime.new(2014, 12, 29, 4, 0, 0)),
          data: { things: 'stuff', how_many: 14 }.to_json
        },
        {
          application_name: 'test_app',
          activity_name: 'butts',
          timestamp: Cassandra::Uuid::Generator.new.at(DateTime.new(2014, 12, 29, 4, 0, 0)),
          data: { things: 'things', how_many: 4 }.to_json
        }
      ]
    end

    context "with no registered loggers" do
      it "executes the default loggers" do
        KennyLoggins::Logger.batch_log(event_data)

        results = KennyLoggins::ActivityLogItem.where(application_name: 'test_app')
        expect(results.count).to eq 2
      end
    end

    context "with registered loggers" do
      it "executes all matching registered loggers" do
        KennyLoggins::Logger.register_log_item_type(MatchingLogItem)
        KennyLoggins::Logger.register_log_item_type(NonMatchingLogItem)
        KennyLoggins::Logger.batch_log(event_data)

        matching_results = MatchingLogItem.where(blah: 14)
        expect(matching_results.count).to eq(1)

        expect(matching_results.first.blah).to eq(14)
        expect(matching_results.first.whatever).to eq('stuff')

        non_matching_results = NonMatchingLogItem.where(blah: 14)
        expect(non_matching_results.count).to eq(0)
      end
    end

    it "executes all default loggers" do
      KennyLoggins::Logger.register_log_item_type(MatchingLogItem)
      KennyLoggins::Logger.register_log_item_type(NonMatchingLogItem)
      KennyLoggins::Logger.batch_log(event_data)

      results = KennyLoggins::ActivityLogItem.where(application_name: 'test_app')
      expect(results.count).to eq(2)
    end
  end

  describe ".log" do
    let(:event_data) do
      {
        application_name: 'test_app',
        activity_name: 'cool event',
        timestamp: Cassandra::Uuid::Generator.new.at(DateTime.new(2014, 12, 29, 4, 0, 0)),
        data: { things: 'stuff', how_many: 14 }.to_json
      }
    end

    context "with no registered loggers" do
      it "executes the default loggers" do
        KennyLoggins::Logger.log(event_data)

        results = KennyLoggins::ActivityLogItem.where(application_name: 'test_app')
        expect(results.count).to eq(1)
      end
    end

    context "with registered loggers" do
      before(:each) do
        KennyLoggins::Logger.register_log_item_type(MatchingLogItem)
        KennyLoggins::Logger.register_log_item_type(NonMatchingLogItem)
        KennyLoggins::Logger.log(event_data)
      end

      it "executes all matching registered loggers" do
        matching_results = MatchingLogItem.where(blah: 14)
        expect(matching_results.count).to eq(1)

        expect(matching_results.first.blah).to eq(14)
        expect(matching_results.first.whatever).to eq('stuff')

        non_matching_results = NonMatchingLogItem.where(blah: 14)
        expect(non_matching_results.count).to eq(0)
      end

      it "executes all default loggers" do
        results = KennyLoggins::ActivityLogItem.where(application_name: 'test_app')
        expect(results.count).to eq(1)
      end
    end
  end
end
