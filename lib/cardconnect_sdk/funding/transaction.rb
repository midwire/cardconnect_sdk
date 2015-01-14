module CardconnectSdk
  module Funding
    class Transaction
      include Attributable

      attr_reader :fundingtxnid, :fundingid, :cardtype, :cardbrand, :cardnumber,
                  :status, :type, :retref, :date, :amount, :currency,
                  :interchangeunitfee, :interchangepercentfee
    end
  end
end

# {
#    "cardtype": "Credit",
#    "status": "Processed",
#    "retref": null,
#    "interchangeunitfee": null,
#    "cardnumber": "44XXXXXXXXXX4329",
#    "type": "Sale",
#    "fundingid": 13899,
#    "interchangepercentfee": null,
#    "date": "2014-03-31",
#    "currency": "USD",
#    "cardbrand": "Visa",
#    "amount": 995,
#    "fundingtxnid": 25
# }
