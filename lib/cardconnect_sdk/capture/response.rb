module CardconnectSdk
  module Capture
    class Response
      include Attributable

      attr_accessor :amount, :setlstat, :retref, :merchid, :account

    end
  end
end
