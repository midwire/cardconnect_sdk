module CardconnectSdk
  module Inquire
    class Request
      include Attributable

      # Standard Attributes for all inquiries
      attr_accessor :merchid, :retref
      
    end
  end
end
