module CardconnectSdk
  module Profile
    class Request
      include Attributable

      # Standard Attributes for all profiles
      attr_accessor :merchid, :profileid, :acctid
      
    end
  end
end
