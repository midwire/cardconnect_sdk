module CardconnectSdk
  module Refund
    class Response
      include Attributable

      attr_reader :amount, :resptext, :authcode, :respcode, :retref, :merchid,
                  :account, :respproc, :respstat

      attr_reader :cvvresp, :avsresp

    end
  end
end

# {
#   "amount": "59.60",
#   "resptext": "Approval",
#   "authcode": "REFUND",
#   "respcode": "00",
#   "retref": "288010185242",
#   "merchid": "000000927996",
#   "cvvresp": "M",
#   "account": "41XXXXXXXXXX4113",
#   "avsresp": "Z",
#   "respproc": "PPS",
#   "respstat": "A"
# }