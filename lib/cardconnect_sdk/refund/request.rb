module CardconnectSdk
  module Refund
    class Request
      include Attributable

      # Standard Attributes for all refunds
      attr_accessor :merchid, :retref, :amount
      
    end
  end
end
