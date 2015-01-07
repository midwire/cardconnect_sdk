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
        self.new(JSON.parse(json))
      end

    end
  end
end

# [
#   {
#     "txns": [
#       {
#         "setlstat": "N",
#         "retref": "179001161341"
#       },
#       {
#         "setlstat": "Y",
#         "retref": "179002161341"
#       }
#     ],
#     "batchid": "71742042",
#     "hoststat": "GB",
#     "hostbatch": "71742041"
#   }
# ]
