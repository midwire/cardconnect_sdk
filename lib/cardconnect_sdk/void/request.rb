module CardconnectSdk
  module Void
    class Request
      include Attributable

      # Standard Attributes for all voids
      attr_accessor :merchid, :retref, :amount
      
    end
  end
end
