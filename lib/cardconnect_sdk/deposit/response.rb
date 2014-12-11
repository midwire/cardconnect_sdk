module CardconnectSdk
  module Deposit
    class Response
      include Attributable

      attr_reader :deposits

      def initialize(deposits=[])
        @deposits = []
        deposits.each do |dep|
          @deposits << AchDeposit.new(dep)
        end
      end

      def self.from_json(json)
        self.new(JSON.parse(json))
      end

    end
  end
end

# [
#   {
#     "cardtype": "VI",
#     "postdate": "20121009",
#     "cbakamnt": "0.00",
#     "feeamnt": "0.55",
#     "currency": "USD",
#     "amount": "11.00",
#     "txns": [
#       {
#         "merchbatch": 92821429,
#         "retref": "282005142924",
#         "hostbatch": "1429",
#         "feeamnt": "0.00",
#         "action": "DEB",
#         "depamnt": "11.00"
#       }
#     ],
#     "resptext": "",
#     "depositid": 7,
#     "merchid": "000000927996",
#     "action": "DEB",
#     "actdate": "20121008",
#     "cardproc": "FNOR"
#   },
#   {
#     "cardtype": "MC",
#     "postdate": "20121009",
#     "cbakamnt": "0.00",
#     "feeamnt": "0.55",
#     "currency": "USD",
#     "amount": "11.00",
#     "txns": [
#       {
#         "merchbatch": 92821429,
#         "retref": "282006142924",
#         "hostbatch": "1429",
#         "feeamnt": "0.00",
#         "action": "DEB",
#         "depamnt": "11.00"
#       }
#     ],
#     "resptext": "",
#     "depositid": 7,
#     "merchid": "000000927996",
#     "action": "DEB",
#     "actdate": "20121008",
#     "cardproc": "FNOR"
#   }
# ]
