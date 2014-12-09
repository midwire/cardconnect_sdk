module CardconnectSdk
  module SettlementStatus
    class Response
      include Attributable

      attr_reader :txns

      def initialize(json)
        @txns = JSON.parse(json)
      end

      def self.from_json(json)
        self.new(json)
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
