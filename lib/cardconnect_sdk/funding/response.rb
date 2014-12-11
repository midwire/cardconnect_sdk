module CardconnectSdk
  module Funding
    class Response
      include Attributable

      attr_reader :merchid, :fundingmasterid, :fundingdate, :datechanged

      attr_reader :txns, :fundings, :adjustments

      def initialize(attrs={})
        attrs.symbolize_keys!
        txns        = attrs.delete(:txns)
        fundings    = attrs.delete(:fundings)
        adjustments = attrs.delete(:adjustments)

        super(attrs)

        unpack_txns(txns)
        unpack_fundings(fundings)
        unpack_adjustments(adjustments)
      end

      def self.from_json(json)
        self.new(JSON.parse(json))
      end

      private

      def unpack_txns(txns=[])
        @txns = txns.map { |tx| Transaction.new(tx) }
      end

      def unpack_fundings(fundings=[])
        @fundings = fundings.map { |f| FundingNode.new(f) }
      end

      def unpack_adjustments(adjustments=[])
        @adjustments = adjustments.map { |adj| Adjustment.new(adj) }
      end

    end
  end
end

# {
#    "txns":    [
#             {
#          "cardtype": "Credit",
#          "status": "Processed",
#          "retref": null,
#          "interchangeunitfee": null,
#          "cardnumber": "44XXXXXXXXXX4329",
#          "type": "Sale",
#          "fundingid": 13899,
#          "interchangepercentfee": null,
#          "date": "2014-03-31",
#          "currency": "USD",
#          "cardbrand": "Visa",
#          "amount": 995,
#          "fundingtxnid": 25
#       },
#             {
#          "cardtype": "Credit",
#          "status": "Processed",
#          "retref": null,
#          "interchangeunitfee": null,
#          "cardnumber": "37XXXXXXXXXX003",
#          "type": "Sale",
#          "fundingid": 13900,
#          "interchangepercentfee": null,
#          "date": "2014-03-31",
#          "currency": "USD",
#          "cardbrand": "American Express",
#          "amount": 1495,
#          "fundingtxnid": 25
#       },
#             {
#          "cardtype": "Credit",
#          "status": "Processed",
#          "retref": null,
#          "interchangeunitfee": null,
#          "cardnumber": "52XXXXXXXXXX7030",
#          "type": "Sale",
#          "fundingid": 13907,
#          "interchangepercentfee": null,
#          "date": "2014-03-31",
#          "currency": "USD",
#          "cardbrand": "Mastercard",
#          "amount": 1145,
#          "fundingtxnid": 25
#       },
#             {
#          "cardtype": "Credit",
#          "status": "Processed",
#          "retref": null,
#          "interchangeunitfee": null,
#          "cardnumber": "45XXXXXXXXXX1081",
#          "type": "Sale",
#          "fundingid": 13909,
#          "interchangepercentfee": null,
#          "date": "2014-03-31",
#          "currency": "USD",
#          "cardbrand": "Visa",
#          "amount": 1495,
#          "fundingtxnid": 25
#       }
#    ],
#    "fundingdate": "2014-03-31",
#    "merchid": "496400000840",
#    "datechanged": null,
#    "fundings": [   {
#       "totalfunding": 3635,
#       "ddanumber": "5XXXXX1756",
#       "datechanged": "2014-04-11",
#       "interchangefee": 0,
#       "fundingid": 405,
#       "fundingmasterid": 25,
#       "servicecharge": 0,
#       "currency": "USD",
#       "fee": 0,
#       "dateadded": "2014-04-11",
#       "adjustment": 0,
#       "netsales": 5130,
#       "thirdparty": -1495,
#       "otheradjustment": 0,
#       "reversal": 0,
#       "abanumber": "054000030"
#    }],
#    "fundingmasterid": 25,
#    "adjustments": [   {
#       "amount": -1495,
#       "category": "THIRD PARTY",
#       "dateadded": "2014-04-11",
#       "description": "THIRD PARTY ADJUSTMENTS",
#       "merchid": "496202840880",
#       "datechanged": "2014-04-11",
#       "type": "THIRD PARTY ADJUSTMENTS",
#       "fundingmasterid": 25,
#       "fundingadjustmentid": 1081,
#       "currency": "USD"
#    }]
# }