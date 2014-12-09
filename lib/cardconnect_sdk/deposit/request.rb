module CardconnectSdk
  module Deposit
    class Request
      include Attributable

      # Standard Attributes for all deposits
      attr_accessor :merchid, :date
      
    end
  end
end
