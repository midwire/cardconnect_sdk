module CardconnectSdk
  module SettlementStatus
    class Request
      include Attributable

      # Standard Attributes for all settlestat
      attr_accessor :merchid, :date, :batchid
      
    end
  end
end
