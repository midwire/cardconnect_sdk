module CardconnectSdk
  module SettlementStatus
    class Transaction
      include Attributable

      attr_reader :setlstat, :retref
      
      def settled?
        setlstat == 'Y'
      end
    end
  end
end
