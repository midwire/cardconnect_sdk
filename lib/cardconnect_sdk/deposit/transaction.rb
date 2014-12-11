module CardconnectSdk
  module Deposit
    class Transaction
      include Attributable

      attr_reader :retref, :action, :merchbatch, :hostbatch, :depamnt, :feeamnt
      
    end
  end
end

# {
#   "merchbatch": 92821429,
#   "retref": "282005142924",
#   "hostbatch": "1429",
#   "feeamnt": "0.00",
#   "action": "DEB",
#   "depamnt": "11.00"
# }
