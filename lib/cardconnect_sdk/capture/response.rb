module CardconnectSdk
  module Capture
    class Response
      include Attributable
      include Helpers::Response

      attr_reader :amount, :setlstat, :retref, :merchid, :account,
                  :respcode, :resptext, :respproc, :respstat, :batchid

    end
  end
end
