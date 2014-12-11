module CardconnectSdk
  module Funding
    class FundingNode
      include Attributable

      attr_reader :fundingid, :fundingmasterid, :totalfunding, :netsales, :currency,
                  :fee, :servicecharge, :interchangefee, :reversal, :adjustment, :otheradjustment,
                  :thirdparty, :ddanumber, :abanumber, :dateadded, :datechanged
    end
  end
end

# {
#   "totalfunding": 3635,
#   "ddanumber": "5XXXXX1756",
#   "datechanged": "2014-04-11",
#   "interchangefee": 0,
#   "fundingid": 405,
#   "fundingmasterid": 25,
#   "servicecharge": 0,
#   "currency": "USD",
#   "fee": 0,
#   "dateadded": "2014-04-11",
#   "adjustment": 0,
#   "netsales": 5130,
#   "thirdparty": -1495,
#   "otheradjustment": 0,
#   "reversal": 0,
#   "abanumber": "054000030"
# }
