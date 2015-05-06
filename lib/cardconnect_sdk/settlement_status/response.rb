module CardconnectSdk
  module SettlementStatus
    class Response
      include Attributable

      attr_reader :batches

      def initialize(batches=[])
        @batches = []
        batches.each do |batch|
          @batches << Batch.new(batch)
        end
      end

      # Overridden because the json returns an array instead of
      # a typical hash, so deep_stringify_keys would fail.
      def self.from_json(json)
        return self.new if empty?(json)
        self.new(JSON.parse(json))
      end

      def self.empty?(json)
        true if json.include?('Null')
      end

    end
  end
end
