module CardconnectSdk
  module Deposit
    class AchDeposit
      include Attributable

      attr_reader :cardtype, :postdate, :amount, :cbakamnt, :feeamnt, :currency,
                  :resptext, :depositid, :merchid, :action, :actdate, :cardproc

      attr_reader :txns

      def initialize(attrs={})
        attrs.deep_symbolize_keys!
        txns = attrs.delete(:txns)

        super(attrs)

        unpack_txns(txns)
      end

      private

      def unpack_txns(txns=[])
        @txns = txns.map { |tx| Transaction.new(tx) }
      end
    end
  end
end

# {
#   "cardtype": "VI",
#   "postdate": "20121009",
#   "cbakamnt": "0.00",
#   "feeamnt": "0.55",
#   "currency": "USD",
#   "amount": "11.00",
#   "txns": [
#     {
#       "merchbatch": 92821429,
#       "retref": "282005142924",
#       "hostbatch": "1429",
#       "feeamnt": "0.00",
#       "action": "DEB",
#       "depamnt": "11.00"
#     }
#   ],
#   "resptext": "",
#   "depositid": 7,
#   "merchid": "000000927996",
#   "action": "DEB",
#   "actdate": "20121008",
#   "cardproc": "FNOR"
# }
