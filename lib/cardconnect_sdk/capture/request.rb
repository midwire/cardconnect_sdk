module CardconnectSdk
  module Capture
    class Request
      include Attributable

      # Standard Attributes for all captures
      attr_accessor :merchid, :retref, :authcode, :amount, :invoiceid
      
    end
  end
end
