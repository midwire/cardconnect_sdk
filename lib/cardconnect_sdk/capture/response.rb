module CardconnectSdk
  module Capture
    class Response
      include Attributable

      attr_reader :amount, :setlstat, :retref, :merchid, :account

    end
  end
end
