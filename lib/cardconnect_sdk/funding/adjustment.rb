module CardconnectSdk
  module Funding
    class Adjustment
      include Attributable

      attr_reader :fundingadjustmentid, :fundingmasterid, :merchid,
                  :type, :category, :description, :amount, :currency,
                  :dateadded, :datechanged
    end
  end
end

# {
#   "amount": -1495,
#   "category": "THIRD PARTY",
#   "dateadded": "2014-04-11",
#   "description": "THIRD PARTY ADJUSTMENTS",
#   "merchid": "496202840880",
#   "datechanged": "2014-04-11",
#   "type": "THIRD PARTY ADJUSTMENTS",
#   "fundingmasterid": 25,
#   "fundingadjustmentid": 1081,
#   "currency": "USD"
# }
