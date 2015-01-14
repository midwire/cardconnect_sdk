module CardconnectSdk
  module Inquire
    class Response
      include Attributable
      include Helpers::Response

      attr_reader :amount, :currency, :resptext, :setlstat, :authcode, :respcode,
                  :retref, :merchid, :account, :respproc, :respstat

      attr_reader :cvvresp, :avsresp

    end
  end
end

# {
#   "amount": "596.00",
#   "resptext": "Approval",
#   "setlstat": "NOTCAPTURED",
#   "authcode": "PPS272",
#   "respcode": "00",
#   "retref": "288015190411",
#   "merchid": "000000927996",
#   "cvvresp": "M",
#   "account": "41XXXXXXXXXX4113",
#   "avsresp": "Z",
#   "respproc": "FNOR",
#   "respstat": "A"
# }