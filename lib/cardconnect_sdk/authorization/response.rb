module CardconnectSdk
  module Authorization
    class Response
      include Attributable

      attr_reader :respstat, :account, :token, :retref, :amount, :merchid, :commcard,
                  :respcode, :resptext, :avsresp, :cvvresp, :authcode, :respproc
    end
  end
end
