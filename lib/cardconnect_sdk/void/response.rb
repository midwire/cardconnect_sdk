module CardconnectSdk
  module Void
    class Response
      include Attributable
      include Helpers::Response

      attr_reader :amount, :resptext, :authcode, :respcode, :retref, :merchid,
                  :account, :respproc, :respstat

      attr_reader :cvvresp, :avsresp
    end
  end
end
